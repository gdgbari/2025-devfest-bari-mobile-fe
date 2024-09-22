/// Exception that occurs when the request does not include the [quizId]
class InvalidQuizRequestError implements Exception {}

/// Exception that occurs when the [quizId] does not exists on the server
class QuizNotFoundError implements Exception {}

/// Exception that occurs when the requested quiz is not open
class QuizNotOpenError implements Exception {}

/// Exception that occurs when a [questionId] of the quiz does not exists on the server
class QuestionNotFoundError implements Exception {}

/// Exception that occurs when ??? //? TODO: Ask to @nico
class QuizStartTimeNotFoundError implements Exception {}

/// Exception that occurs when the time of the quiz is over
class QuizTimeIsUpError implements Exception {}

/// Exception that occurs when the submission does not include a valid [Quiz] object
class InvalidQuizSubmissionError implements Exception {}

/// Exception that occurs when the [Quiz] was already submitted
class QuizAlreadySubmittedError implements Exception {}

/// Exception that occurs when ??? //? TODO: Ask to @nico
class QuizHistoryNotFoundError implements Exception {}

/// Exception that occurs when the quiz response status code is 500
class UnknownQuizError implements Exception {}
