import 'package:bizzie/core/constants/security_constants.dart';

enum SecurityThreatType {
  appIntegrity,
  obfuscationIssues,
  debugging,
  deviceBinding,
  deviceID,
  hooks,
  privilegedAccess,
  secureHardwareNotAvailable,
  simulator,
  unofficialStore,
  simulatorDeviceInfo,
  unknown;

  static SecurityThreatType fromConstant(String constant) {
    if (constant == SecurityConstants.appIntegrity) {
      return appIntegrity;
    }
    if (constant == SecurityConstants.obfuscationIssues) {
      return obfuscationIssues;
    }
    if (constant == SecurityConstants.debugging) {
      return debugging;
    }
    if (constant == SecurityConstants.deviceBinding) {
      return deviceBinding;
    }
    if (constant == SecurityConstants.deviceID) {
      return deviceID;
    }
    if (constant == SecurityConstants.hooks) {
      return hooks;
    }
    if (constant == SecurityConstants.privilegedAccess) {
      return privilegedAccess;
    }
    if (constant == SecurityConstants.secureHardwareNotAvailable) {
      return secureHardwareNotAvailable;
    }
    if (constant == SecurityConstants.simulator) {
      return simulator;
    }
    if (constant == SecurityConstants.unofficialStore) {
      return unofficialStore;
    }
    if (constant == SecurityConstants.simulatorDeviceInfo) {
      return simulatorDeviceInfo;
    }
    return unknown;
  }

  String get analyticsValue => name;
}

enum SecurityLockoutAction {
  closeApp;

  String get analyticsValue => 'close_app';
}
