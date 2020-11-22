defmodule StateMachineTest do
  use ExUnit.Case
  doctest StateMachine

  use StateMachine

  state do
    transition(:foo, :bar)
    transition("foo", "bar")
    transition(:foo, :baz)
    transition("foo", "baz")
    transition(:bar, :baz)
    transition("bar", "baz")
  end

  describe "valid_transition?" do
    test "returns true to transition from foo to foo" do
      refute valid_transition?(%{status: :foo}, %{status: :foo})
    end

    test "[Atom] returns true to transition from foo to foo" do
      refute valid_transition?(:foo, :foo)
    end

    test "[String] returns true to transition from foo to foo" do
      refute valid_transition?("foo", "foo")
    end

    test "returns true to transition from baz to foo" do
      refute valid_transition?(%{status: :baz}, %{status: :foo})
    end

    test "[Atom] returns true to transition from baz to foo" do
      refute valid_transition?(:baz, :foo)
    end

    test "[String] returns true to transition from baz to foo" do
      refute valid_transition?("baz", "foo")
    end

    test "returns true to transition from baz to bar" do
      refute valid_transition?(%{status: :baz}, %{status: :bar})
    end

    test "[Atom] returns true to transition from baz to bar" do
      refute valid_transition?(:baz, :bar)
    end

    test "[String] returns true to transition from baz to bar" do
      refute valid_transition?("baz", "bar")
    end

    test "returns true to transition from foo to bar" do
      assert valid_transition?(%{status: :foo}, %{status: :bar})
    end

    test "[Atom] returns true to transition from foo to bar" do
      assert valid_transition?(:foo, :bar)
    end

    test "[String] returns true to transition from foo to bar" do
      assert valid_transition?("foo", "bar")
    end

    test "returns true to transition from foo to baz" do
      assert valid_transition?(%{status: :foo}, %{status: :baz})
    end

    test "[Atom] returns true to transition from foo to baz" do
      assert valid_transition?(:foo, :baz)
    end

    test "[String] returns true to transition from foo to baz" do
      assert valid_transition?("foo", "baz")
    end

    test "returns true to transition from bar to baz" do
      assert valid_transition?(%{status: :bar}, %{status: :baz})
    end

    test "[Atom] returns true to transition from bar to baz" do
      assert valid_transition?(:bar, :baz)
    end

    test "[String] returns true to transition from bar to baz" do
      assert valid_transition?("bar", "baz")
    end
  end
end
