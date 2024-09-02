/// Exception that occurs when the [talkId] does not exists on the server
class TalkNotFoundError implements Exception {}

/// Exception that occurs when the talk reponse status code is 500
class UnknownTalkError implements Exception {}
