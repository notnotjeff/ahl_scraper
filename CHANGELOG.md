# CHANGELOG

## 0.2

### Games

- `Penalty` resource now includes its AHL id under the `id` attribute

### RosterPlayers

- Changed `shoots` to `handedness` and fixed value so that goalies get a proper handedness

### Players

- Merged `shoots` and `catches` into `handedness` attribute

### Penalties

- Add `penalty_shot` type
- Add `bench?` for bench related penalties
- Add `invalid?` for tagging broken penalties that can be skipped
