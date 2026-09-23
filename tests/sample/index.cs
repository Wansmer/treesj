// Code examples based on https://learnxinyminutes.com/docs/csharp/

using System;
using System.Collections.Generic;

// RESULT OF JOIN (node "attribute_list", preset default)
[Serializable, Obsolete("Use Frame instead")]
class Frame { }

// RESULT OF SPLIT (node "attribute_list", preset default)
[
  Serializable,
  Obsolete("Use Frame instead"),
]
class Frame { }

// RESULT OF JOIN (node "attribute", preset default)
[Obsolete("Use Wheel instead", true)]
class Wheel { }

// RESULT OF SPLIT (node "attribute", preset default)
[Obsolete(
  "Use Wheel instead",
  true
)]
class Wheel { }

// RESULT OF JOIN (node "type_parameter_list", preset default)
class Pair<TFirst, TSecond> { }

// RESULT OF SPLIT (node "type_parameter_list", preset default)
class Pair<
  TFirst,
  TSecond
> { }

// RESULT OF JOIN (node "enum_member_declaration_list", preset default)
enum Gear { Low, Mid, High }

// RESULT OF SPLIT (node "enum_member_declaration_list", preset default)
enum Gear {
  Low,
  Mid,
  High,
}

// RESULT OF JOIN (node "enum_declaration", preset default)
enum Gear { Low, Mid, High }

// RESULT OF SPLIT (node "enum_declaration", preset default)
enum Gear {
  Low,
  Mid,
  High,
}

// RESULT OF JOIN (node "delegate_declaration", preset default)
delegate int Shift(int gear, bool force);

// RESULT OF SPLIT (node "delegate_declaration", preset default)
delegate int Shift(
  int gear,
  bool force
);

class Bicycle
{
  // RESULT OF JOIN (node "constructor_declaration", preset default)
  public Bicycle(int startCadence, int startSpeed, string name) { }

  // RESULT OF SPLIT (node "constructor_declaration", preset default)
  public Bicycle(
    int startCadence,
    int startSpeed,
    string name
  ) { }

  // RESULT OF JOIN (node "method_declaration", preset default)
  public void SpeedUp(int increment, bool logChange, string reason) { }

  // RESULT OF SPLIT (node "method_declaration", preset default)
  public void SpeedUp(
    int increment,
    bool logChange,
    string reason
  ) { }

  // RESULT OF JOIN (node "accessor_list", preset default)
  public int Cadence { get; set; }

  // RESULT OF SPLIT (node "accessor_list", preset default)
  public int Cadence {
    get;
    set;
  }

  // RESULT OF JOIN (node "bracketed_parameter_list", preset default)
  public int this[int row, int column] { get => 0; }

  // RESULT OF SPLIT (node "bracketed_parameter_list", preset default)
  public int this[
    int row,
    int column
  ] { get => 0; }

  // RESULT OF JOIN (node "block", preset default)
  public int GetCadence() { Report(); return Cadence; }

  // RESULT OF SPLIT (node "block", preset default)
  public int GetCadence() {
    Report();
    return Cadence;
  }

  // RESULT OF JOIN (node "indexer_declaration", preset default)
  public int this[int row, int column] => 0;

  // RESULT OF SPLIT (node "indexer_declaration", preset default)
  public int this[
    int row,
    int column
  ] => 0;

  // RESULT OF JOIN (node "operator_declaration", preset default)
  public static Bicycle operator +(Bicycle one, Bicycle two) => one;

  // RESULT OF SPLIT (node "operator_declaration", preset default)
  public static Bicycle operator +(
    Bicycle one,
    Bicycle two
  ) => one;

  // RESULT OF JOIN (node "conversion_operator_declaration", preset default)
  public static explicit operator int(Bicycle bike) => 0;

  // RESULT OF SPLIT (node "conversion_operator_declaration", preset default)
  public static explicit operator int(
    Bicycle bike
  ) => 0;

  // RESULT OF JOIN (node "constructor_initializer", preset default)
  public Bicycle(int startCadence) : this(startCadence, 0, "bike") { }

  // RESULT OF SPLIT (node "constructor_initializer", preset default)
  public Bicycle(int startCadence) : this(
    startCadence,
    0,
    "bike"
  ) { }

  // RESULT OF JOIN (node "tuple_type", preset default)
  public (int gear, string name) Describe() => (1, "low");

  // RESULT OF SPLIT (node "tuple_type", preset default)
  public (
    int gear,
    string name
  ) Describe() => (1, "low");

  public void Ride()
  {
    var grid = new int[3, 3];
    var row = 1;
    var column = 2;
    var items = new List<int>();
    var gate = new object();
    var gear = 1;
    var radius = 2;
    var pressure = 3;

    // RESULT OF JOIN (node "invocation_expression", preset default)
    Console.WriteLine("pi = {0:F5}", Math.PI);

    // RESULT OF SPLIT (node "invocation_expression", preset default)
    Console.WriteLine(
      "pi = {0:F5}",
      Math.PI
    );

    // RESULT OF JOIN (node "object_creation_expression", preset default)
    var wheel = new Wheel(radius, pressure);

    // RESULT OF SPLIT (node "object_creation_expression", preset default)
    var wheel = new Wheel(
      radius,
      pressure
    );

    // RESULT OF JOIN (node "implicit_object_creation_expression", preset default)
    Wheel spare = new(radius, pressure);

    // RESULT OF SPLIT (node "implicit_object_creation_expression", preset default)
    Wheel spare = new(
      radius,
      pressure
    );

    // RESULT OF JOIN (node "type_argument_list", preset default)
    var gears = new Dictionary<string, int>();

    // RESULT OF SPLIT (node "type_argument_list", preset default)
    var gears = new Dictionary<
      string,
      int
    >();

    // RESULT OF JOIN (node "initializer_expression", preset default)
    var ratios = new List<int> { 1, 2, 3 };

    // RESULT OF SPLIT (node "initializer_expression", preset default)
    var ratios = new List<int> {
      1,
      2,
      3,
    };

    // RESULT OF JOIN (node "collection_expression", preset default)
    int[] values = [1, 2, 3];

    // RESULT OF SPLIT (node "collection_expression", preset default)
    int[] values = [
      1,
      2,
      3,
    ];

    // RESULT OF JOIN (node "element_binding_expression", preset default)
    var cell = grid?[row, column];

    // RESULT OF SPLIT (node "element_binding_expression", preset default)
    var cell = grid?[
      row,
      column
    ];

    // RESULT OF JOIN (node "bracketed_argument_list", preset default)
    var slot = grid[row, column];

    // RESULT OF SPLIT (node "bracketed_argument_list", preset default)
    var slot = grid[
      row,
      column
    ];

    // RESULT OF JOIN (node "element_access_expression", preset default)
    var slot = grid[row, column];

    // RESULT OF SPLIT (node "element_access_expression", preset default)
    var slot = grid[
      row,
      column
    ];

    // RESULT OF JOIN (node "tuple_expression", preset default)
    var gear = (1, "low");

    // RESULT OF SPLIT (node "tuple_expression", preset default)
    var gear = (
      1,
      "low"
    );

    // RESULT OF JOIN (node "switch_expression", preset default)
    var label = gear switch { 1 => "low", _ => "high" };

    // RESULT OF SPLIT (node "switch_expression", preset default)
    var label = gear switch {
      1 => "low",
      _ => "high",
    };

    // RESULT OF JOIN (node "list_pattern", preset default)
    if (items is [1, 2, 3]) { Report(); }

    // RESULT OF SPLIT (node "list_pattern", preset default)
    if (items is [
      1,
      2,
      3,
    ]) { Report(); }

    // RESULT OF JOIN (node "property_pattern_clause", preset default)
    if (this is { Cadence: 1, Speed: 2 }) { Report(); }

    // RESULT OF SPLIT (node "property_pattern_clause", preset default)
    if (this is {
      Cadence: 1,
      Speed: 2,
    }) { Report(); }

    // RESULT OF JOIN (node "if_statement", preset default)
    if (Cadence > 0) { Report(); Stop(); }

    // RESULT OF SPLIT (node "if_statement", preset default)
    if (Cadence > 0) {
      Report();
      Stop();
    }

    // RESULT OF JOIN (node "while_statement", preset default)
    while (Cadence > 0) { Report(); Stop(); }

    // RESULT OF SPLIT (node "while_statement", preset default)
    while (Cadence > 0) {
      Report();
      Stop();
    }

    // RESULT OF JOIN (node "do_statement", preset default)
    do { Report(); Stop(); } while (Cadence > 0);

    // RESULT OF SPLIT (node "do_statement", preset default)
    do {
      Report();
      Stop();
    } while (Cadence > 0);

    // RESULT OF JOIN (node "for_statement", preset default)
    for (int index = 0; index < 3; index++) { Report(); Stop(); }

    // RESULT OF SPLIT (node "for_statement", preset default)
    for (int index = 0; index < 3; index++) {
      Report();
      Stop();
    }

    // RESULT OF JOIN (node "foreach_statement", preset default)
    foreach (var item in items) { Report(); Stop(); }

    // RESULT OF SPLIT (node "foreach_statement", preset default)
    foreach (var item in items) {
      Report();
      Stop();
    }

    // RESULT OF JOIN (node "using_statement", preset default)
    using (var file = Open()) { Report(); Stop(); }

    // RESULT OF SPLIT (node "using_statement", preset default)
    using (var file = Open()) {
      Report();
      Stop();
    }

    // RESULT OF JOIN (node "lock_statement", preset default)
    lock (gate) { Report(); Stop(); }

    // RESULT OF SPLIT (node "lock_statement", preset default)
    lock (gate) {
      Report();
      Stop();
    }

    // RESULT OF JOIN (node "checked_statement", preset default)
    checked { Report(); Stop(); }

    // RESULT OF SPLIT (node "checked_statement", preset default)
    checked {
      Report();
      Stop();
    }

    // RESULT OF JOIN (node "unsafe_statement", preset default)
    unsafe { Report(); Stop(); }

    // RESULT OF SPLIT (node "unsafe_statement", preset default)
    unsafe {
      Report();
      Stop();
    }

    // RESULT OF JOIN (node "fixed_statement", preset default)
    fixed (int* pin = &row) { Report(); Stop(); }

    // RESULT OF SPLIT (node "fixed_statement", preset default)
    fixed (int* pin = &row) {
      Report();
      Stop();
    }

    // RESULT OF JOIN (node "try_statement", preset default)
    try { Report(); } catch (Exception error) { Log(error); } finally { Stop(); }

    // RESULT OF SPLIT (node "try_statement", preset default)
    try {
      Report();
    } catch (Exception error) { Log(error); } finally { Stop(); }

    // RESULT OF JOIN (node "catch_clause", preset default)
    try { Report(); } catch (Exception error) { Log(error); } finally { Stop(); }

    // RESULT OF SPLIT (node "catch_clause", preset default)
    try { Report(); } catch (Exception error) {
      Log(error);
    } finally { Stop(); }

    // RESULT OF JOIN (node "finally_clause", preset default)
    try { Report(); } catch (Exception error) { Log(error); } finally { Stop(); }

    // RESULT OF SPLIT (node "finally_clause", preset default)
    try { Report(); } catch (Exception error) { Log(error); } finally {
      Stop();
    }

    // RESULT OF JOIN (node "local_function_statement", preset default)
    void Shift(int gear, bool force, string reason) { }

    // RESULT OF SPLIT (node "local_function_statement", preset default)
    void Shift(
      int gear,
      bool force,
      string reason
    ) { }
  }
}
