# README

1. Precision for some fields could be bigger in migrations file.
2. Context can be added when permitting params. In order to log class name and action name inside the error(Rails 7 feature). Also when unpermitted params comes - it can be handled by raising error.
3. Validations can be moved to seperate form object or some kind of validator.
4. Decided to implement methods as 3 different services. Easier to maintain, extend and to test.
5. Error handling in `CreateMobileLocation` could be improved, for example - seperate handling when record is invalid and when other exceptions are being thrown.
6. Success and Error objects could be implemented as seperate classes to get rid of `Struct` in `CreateMobileLocation` class.
7. `GetLastIdleDuration` - to handle edge cases, improve validations - more info is needed(for example - how often callbacks are coming with mobile location data)
8. For easier setup - created some test data methods inside `test_helper.rb`, usually should be `FactoryBot` or something like that.
9. Did not implement `GetLastDrivingDuration` - very similar logic to `GetLastIdleDuration`.