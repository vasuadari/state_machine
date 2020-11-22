# StateMachine

A tiny package which adds state machine feature to your module.

## Installation

The package can be installed by adding `state_machine` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:state_machine, github: "vasuadari/state_machine"}
  ]
end
```

## Usage

```elixir
defmodule Email do
  use StateMachine

  state do
    transition :created, :queued
    transition :queued, :failed
    transition :queued, :sent
  end
end

defmodule EmailUpdater do
  use Email

  def update(email, attrs) do
    if valid_transition?(email, attrs) do
      #...
    end
  end
end
```
