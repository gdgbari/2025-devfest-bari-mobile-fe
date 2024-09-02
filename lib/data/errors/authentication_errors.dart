/// Exception that occurs when a request is made without authentication
class UnauthenticatedError implements Exception {}

/// Exception that occurs when the [userId] does not exists on the server
class UserNotFoundError implements Exception {}

/// Exception that occurs when the [groupId] does not exists on the server
class GroupNotFoundError implements Exception {}

/// Exception that occurs when the authentication reponse status code is 500
class UnknownAuthenticationError implements Exception {}
