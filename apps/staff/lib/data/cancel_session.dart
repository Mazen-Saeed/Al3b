import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_log.dart';
import 'catalog_provider.dart';
import 'orders_provider.dart';
import 'units_provider.dart';

/// Why a session was cancelled instead of paid. The text is what the log stores.
class CancelReason {
  const CancelReason._();

  static const mistake = 'mistake'; // started by accident
  static const customerLeft = 'customer_left';
  static const deviceProblem = 'device_problem';
  static const other = 'other';

  static const all = [mistake, customerLeft, deviceProblem, other];
}

/// A session cancelled in its first minutes was a slip of the finger: no reason is asked for.
const cancelGrace = Duration(minutes: 3);

/// Ends a session without a bill (nobody pays). Everything about it is written to the activity log, with
/// the amount that was not collected, so the owner can see it.
class SessionCancel {
  SessionCancel(this._ref);

  final Ref _ref;

  /// Is the session past the first minutes, so a reason is needed?
  bool needsReason(String unitId, {DateTime? now}) {
    final unit = _ref.read(unitsProvider).byId(unitId);
    return unit.elapsedAt(now ?? DateTime.now()) > cancelGrace;
  }

  /// What would have been collected: the time played plus the products.
  int uncollected(String unitId, {DateTime? now}) {
    final unit = _ref.read(unitsProvider).byId(unitId);
    return unit.costAt(now ?? DateTime.now()) + _ref.read(ordersProvider).totalFor(unitId);
  }

  /// Cancels the session on [unitId]. Past the first minutes a [reason] is required. Products come back to the
  /// shelf only when the session was a mistake (otherwise they were probably used).
  void cancel(String unitId, {String? reason, DateTime? now}) {
    final at = now ?? DateTime.now();
    final unit = _ref.read(unitsProvider).byId(unitId);
    if (!unit.hasSession) throw StateError('No session on $unitId');
    final late = needsReason(unitId, now: at);
    if (late && reason == null) throw ArgumentError('A reason is needed after $cancelGrace');
    final why = late ? reason! : CancelReason.mistake;
    final amount = uncollected(unitId, now: at);

    final orders = _ref.read(ordersProvider);
    if (why == CancelReason.mistake) {
      final catalog = _ref.read(catalogProvider.notifier);
      for (final line in orders.forUnit(unitId)) {
        catalog.sellFromStock(line.productId, -line.quantity); // negative: stock comes back
      }
    }
    _ref.read(ordersProvider.notifier).clear(unitId);
    _ref.read(unitsProvider.notifier).free(unitId);

    _ref.read(activityLogProvider.notifier).record(
      ActivityKind.sessionCancelled,
      // A cancelled session with money on it is the way to take cash and leave no bill.
      suspicious: late && amount >= largeDiscountLimit,
      details: {'unit': unit.name, 'amount': amount, 'minutes': unit.elapsedAt(at).inMinutes, 'reason': why},
    );
  }
}

final sessionCancelProvider = Provider<SessionCancel>(SessionCancel.new);
