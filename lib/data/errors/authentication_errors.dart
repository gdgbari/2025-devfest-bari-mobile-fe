/// Exception that occurs when the user is already registered
class UserAlreadyRegisteredError implements Exception {}

/// Exception that occurs when the user scan an invalid check-in code
class CheckInCodeNotFoundError implements Exception {}

/// Exception that occurs when the user scan an expired check-in code
class CheckInCodeExpiredError implements Exception {}

/// Exception that occurs when the credentials does not match anything on Firebase Auth
class InvalidCredentialsError implements Exception {}

/// Exception that occurs when a request is made without authentication
class UnauthenticatedError implements Exception {}

/// Exception that occurs when the user does not exists on Firebase Auth
class UserNotFoundError implements Exception {}

/// Exception that occurs when the [groupId] does not exists on the server
class GroupNotFoundError implements Exception {}

/// Exception that occurs when the authentication response status code is 500
class UnknownAuthenticationError implements Exception {}
