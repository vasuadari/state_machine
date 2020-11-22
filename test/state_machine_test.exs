defmodule StateMachineTest do
  use ExUnit.Case
  doctest StateMachine

  use StateMachine

  state do
    transition :foo, :bar
    transition :foo, :baz
    transition :bar, :baz
  end

  describe "valid?" do
    test "returns true to transition from foo to foo" do
      refute valid?(%{status: :foo}, %{status: :foo})
    end

    test "returns true to transition from baz to foo" do
      refute valid?(%{status: :foo}, %{status: :foo})
    end

    test "returns true to transition from baz to bar" do
      refute valid?(%{status: :foo}, %{status: :foo})
    end

    test "returns true to transition from foo to bar" do
      assert valid?(%{status: :foo}, %{status: :bar})
    end

    test "returns true to transition from foo to baz" do
      assert valid?(%{status: :foo}, %{status: :baz})
    end

    test "returns true to transition from bar to baz" do
      assert valid?(%{status: :bar}, %{status: :baz})
    end
  end
end
