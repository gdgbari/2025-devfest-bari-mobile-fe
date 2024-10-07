/// Exception that occurs when the [quizId] is not in a valid format
class QuizInvalidCode implements Exception {}

/// Exception that occurs when the [quizId] does not exists on the server
class QuizNotFoundError implements Exception {}

/// Exception that occurs when the requested quiz is not open
class QuizNotOpenError implements Exception {}

/// Exception that occurs when the time of the quiz is over
class QuizTimeIsUpError implements Exception {}

/// Exception that occurs when the [Quiz] was already submitted
class QuizAlreadySubmittedError implements Exception {}

/// Exception that occurs when the quiz response status code is 500
class UnknownQuizError implements Exception {}
