defmodule StateMachineTest do
  use ExUnit.Case
  doctest StateMachine

  use StateMachine

  state do
    transition :foo, :bar
    transition "foo", "bar"
    transition :foo, :baz
    transition "foo", "baz"
    transition :bar, :baz
    transition "bar", "baz"
  end

  describe "valid?" do
    test "returns true to transition from foo to foo" do
      refute valid?(%{status: :foo}, %{status: :foo})
    end

    test "[Atom] returns true to transition from foo to foo" do
      refute valid?(:foo, :foo)
    end

    test "[String] returns true to transition from foo to foo" do
      refute valid?("foo", "foo")
    end

    test "returns true to transition from baz to foo" do
      refute valid?(%{status: :baz}, %{status: :foo})
    end

    test "[Atom] returns true to transition from baz to foo" do
      refute valid?(:baz, :foo)
    end

    test "[String] returns true to transition from baz to foo" do
      refute valid?("baz", "foo")
    end

    test "returns true to transition from baz to bar" do
      refute valid?(%{status: :baz}, %{status: :bar})
    end

    test "[Atom] returns true to transition from baz to bar" do
      refute valid?(:baz, :bar)
    end

    test "[String] returns true to transition from baz to bar" do
      refute valid?("baz", "bar")
    end

    test "returns true to transition from foo to bar" do
      assert valid?(%{status: :foo}, %{status: :bar})
    end

    test "[Atom] returns true to transition from foo to bar" do
      assert valid?(:foo, :bar)
    end

    test "[String] returns true to transition from foo to bar" do
      assert valid?("foo", "bar")
    end

    test "returns true to transition from foo to baz" do
      assert valid?(%{status: :foo}, %{status: :baz})
    end

    test "[Atom] returns true to transition from foo to baz" do
      assert valid?(:foo, :baz)
    end

    test "[String] returns true to transition from foo to baz" do
      assert valid?("foo", "baz")
    end

    test "returns true to transition from bar to baz" do
      assert valid?(%{status: :bar}, %{status: :baz})
    end

    test "[Atom] returns true to transition from bar to baz" do
      assert valid?(:bar, :baz)
    end

    test "[String] returns true to transition from bar to baz" do
      assert valid?("bar", "baz")
    end
  end
end
