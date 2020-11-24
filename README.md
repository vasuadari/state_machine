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
  use Ecto.Schema
  use StateMachine

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "email" do
    # EmailStatus is a postgres enum custom created
    field(:status, EmailStatus)
  end

  state do
    transition :created, :queued
    transition "created", "queued"
    transition :queued, :failed
    transition "queued", "failed"
    transition :queued, :sent
    transition "queued", "sent"
  end

  def changeset(email \\ %__MODULE__{}, attrs) do
  end

  def update_changeset(email, attrs) do
    email
    |> cast(attrs, [:status])
    |> validate_status(email.status)
  end

  def validate_status(changeset, old_status) do
    status = get_change(changeset, :status)

    if is_nil(status) || valid_transition?(old_status, status) do
      changeset
    else
      add_error(
        changeset,
        :status,
        "status from #{old_status} to #{status} is not allowed"
      )
    end
  end
end
```
