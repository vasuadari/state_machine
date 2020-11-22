defmodule StateMachine do
  defmacro __using__(_opts) do
    quote location: :keep do
      @state_transitions %{}

      import unquote(__MODULE__)
    end
  end

  defmacro state(do: block) do
    quote do
      unquote(block)
    end
  end

  defmacro transition(from, to) do
    quote bind_quoted: [from: from, to: to] do
      {_, state_transitions} =
        Map.get_and_update(
          @state_transitions,
          from,
          fn
            nil ->
              {nil, [to]}

            current_value ->
              {current_value, [to | current_value]}
          end
        )

      @state_transitions state_transitions
    end
  end

  defmacro valid_transition?(from, to) do
    quote bind_quoted: [from: from, to: to] do
      if is_atom(from) or is_binary(from) do
        to in Map.get(@state_transitions, from, [])
      else
        to[:status] in Map.get(@state_transitions, from[:status], [])
      end
    end
  end
end
