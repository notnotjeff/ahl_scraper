# CHANGELOG

## 0.2.0

### RosterPlayers

- Changed `shoots` to `handedness` and fixed value so that goalies get a proper handedness

### Players

- Merged `shoots` and `catches` into `handedness` attribute

### Penalties

- Uses AHL id under the `id` attribute
- Add `penalty_shot` type
- Add `bench?` for bench related penalties
- Add `invalid?` for tagging broken penalties that can be skipped
