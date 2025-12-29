# RentVerse Mobile App - Troubleshooting Report

**TESTED ON:**
**Date:** December 29, 2025  
**Platform:** Android (Flutter)  
**Device:** V2309A

**Team Members with Student ID:**
- 1. Muhammad 'Adli Bin Mohd Ali (2024974573)
- 2. Amir Hafizi Bin Musa (2024745815)
- 3. Nik Muhammad Haziq bin Nik Hasni (2024741073)


---

## Observed Symptoms

When tapping the login button, the following issues were observed:

### Issue 1: Login Button Not Navigating
- User enters credentials and taps "Login"
- API call succeeds with HTTP 200 and returns valid tokens
- App stays on login screen instead of navigating to home
- Console shows: `Access token missing, skip register device`

### Issue 2: 401 Unauthorized on Homepage
- After login navigation was fixed, homepage requests failed
- Multiple 401 errors on `/auth/me`, `/properties`, `/rental/references`
- Error message: `You are not logged in. Please log in to get access.`
- Token refresh attempts also failed

**Log Evidence:**
```
I/flutter: │ 💡 --> GET https://rvapi.ilhamdean.cloud/api/v1/auth/me
I/flutter: │  Headers: {Accept: application/json, Content-Type: application/json}
                       ↑ Missing Authorization header!

I/flutter: │ ⛔ <-- 401 https://rvapi.ilhamdean.cloud/api/v1/auth/me
I/flutter: │ ⛔ Error Data: {status: fail, message: You are not logged in...}
```

---

## Root Cause Analysis

### Bug 1: Token Storage Key Mismatch

**File:** `lib/features/auth/data/source/auth_local_service.dart`

The token was being saved with a **hardcoded string literal** instead of the constant variable:

```dart
// BROKEN CODE (lines 28, 36):
await _sharedPreferences.setString("TOKEN_KEY", " $token");
//                                  ↑ String literal    ↑ Leading space!
```

- `"TOKEN_KEY"` is a literal string, not the constant `TOKEN_KEY`
- The constant `TOKEN_KEY = ApiConstants.tokenKey = 'access_token'`
- Other services read from `'access_token'` but the token was stored under `"TOKEN_KEY"`
- Additionally, a leading space was prepended to the token value

### Bug 2: Authorization Header Typo

**File:** `lib/core/network/interceptors.dart`

The Authorization header name was misspelled:

```dart
// BROKEN CODE (line 35):
options.headers['authorizatiom'] = 'Bearer $token';
//               ↑ Typo: 'm' instead of 'n' at the end
```

- The header `authorizatiom` is not recognized by the server
- All authenticated requests were sent without valid authorization
- Server returned 401 because no `Authorization` header was present

---

## Applied Fix

### Fix 1: Correct Token Storage Key

**File:** `lib/features/auth/data/source/auth_local_service.dart`

```diff
  @override
  Future<void> saveToken(String token) async {
-   await _sharedPreferences.setString("TOKEN_KEY", " $token");
+   await _sharedPreferences.setString(TOKEN_KEY, token);
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
-   await _sharedPreferences.setString("TOKEN_KEY", " $accessToken");
+   await _sharedPreferences.setString(TOKEN_KEY, accessToken);
```

**Changes:**
- Use the constant `TOKEN_KEY` instead of string literal `"TOKEN_KEY"`
- Remove accidental leading space from token value

### Fix 2: Correct Authorization Header Name

**File:** `lib/core/network/interceptors.dart`

```diff
    if (token != null && token.isNotEmpty) {
-     options.headers['authorizatiom'] = 'Bearer $token';
+     options.headers['Authorization'] = 'Bearer $token';
    }
```

**Changes:**
- Fixed typo: `authorizatiom` → `Authorization`

---

## Evidence of Resolution

After applying both fixes:

1. **Login succeeds** - Token is correctly saved under `'access_token'` key
2. **Device registration works** - Token is retrieved and sent with Authorization header
3. **Homepage loads** - All API requests include proper `Authorization: Bearer <token>` header
4. **No more 401 errors** - User profile and properties load successfully

**Post-fix Log Evidence:**
```
I/flutter: │ 💡 --> GET https://rvapi.ilhamdean.cloud/api/v1/auth/me
I/flutter: │  Headers: {Accept: application/json, Content-Type: application/json, 
                        Authorization: Bearer eyJhbGciOiJIUzI1NiI...}
I/flutter: │ 🐛 <-- 200 https://rvapi.ilhamdean.cloud/api/v1/auth/me
```


## Summary

| Issue | Root Cause | File | Line |
|-------|------------|------|------|
| Login not navigating | Token saved under wrong key | `auth_local_service.dart` | 28, 36 |
| 401 on all requests | Typo in Authorization header | `interceptors.dart` | 35 |

Both bugs were simple typos that caused cascading authentication failures throughout the app.
