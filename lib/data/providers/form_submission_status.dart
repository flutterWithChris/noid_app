abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmitSuccess extends FormSubmissionStatus {}

class SubmitFailed extends FormSubmissionStatus {
  final StackTrace exception;

  SubmitFailed(this.exception);
}
