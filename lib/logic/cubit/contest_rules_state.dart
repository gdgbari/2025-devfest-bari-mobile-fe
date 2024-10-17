part of 'contest_rules_cubit.dart';

enum ContestRulesStatus {
  initial,
  fetchInProgress,
  fetchSuccess,
  fetchFailure,
}

class ContestRulesState extends Equatable {
  final ContestRulesStatus status;
  final ContestRules rules;

  const ContestRulesState({
    this.status = ContestRulesStatus.initial,
    this.rules = const ContestRules(),
  });

  ContestRulesState copyWith({
    ContestRulesStatus? status,
    ContestRules? rules,
  }) {
    return ContestRulesState(
      status: status ?? this.status,
      rules: rules ?? this.rules,
    );
  }

  @override
  List<Object> get props => [status, rules];
}
