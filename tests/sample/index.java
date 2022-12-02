// code examples from https://learnxinyminutes.com/docs/java/

class Bicycle {

  // RESULT OF JOIN (node "array_initializer", preset default)
  int[] myIntArray = { 1, 2, 3 };

  // RESULT OF SPLIT (node "array_initializer", preset default)
  int[] myIntArray = {
    1,
    2,
    3,
  };

  // RESULT OF JOIN (node "formal_parameters", preset default)
  public Bicycle(int startCadence, int startSpeed, int startGear, String name) {
    this.gear = startGear;
    this.cadence = startCadence;
  }

  // RESULT OF SPLIT (node "formal_parameters", preset default)
  public Bicycle(
    int startCadence,
    int startSpeed,
    int startGear,
    String name
  ) {
    this.gear = startGear;
    this.cadence = startCadence;
  }

  // RESULT OF JOIN (node "constructor_body", preset default)
  public Bicycle(int startCadence, int startSpeed, int startGear, String name) { this.gear = startGear; this.cadence = startCadence; }

  // RESULT OF SPLIT (node "constructor_body", preset default)
  public Bicycle(int startCadence, int startSpeed, int startGear, String name) {
    this.gear = startGear;
    this.cadence = startCadence;
  }

  // RESULT OF JOIN (node "block", preset default)
  public int getCadence() { return cadence; }

  // RESULT OF SPLIT (node "block", preset default)
  public int getCadence() {
    return cadence;
  }

  public void somePrint() {
    // RESULT OF JOIN (node "argument_list", preset default)
    System.out.printf("pi = %.5f", Math.PI);

    // RESULT OF SPLIT (node "argument_list", preset default)
    System.out.printf(
      "pi = %.5f",
      Math.PI
    );
  }
}

// RESULT OF JOIN (node "annotation_argument_list", preset default)
@Anotatition(id = 2868724, desc = "anotation")
module ano.ta { }

// RESULT OF JOIN (node "annotation_argument_list", preset default)
@Anotatition(
  id = 2868724,
  desc = "anotation"
)
module ano.ta { }

// RESULT OF JOIN (node "enum_body", preset default)
enum HandSign { SCISSOR, PAPER, STONE }

// RESULT OF JOIN (node "enum_body", preset default)
enum HandSign {
  SCISSOR,
  PAPER,
  STONE,
}
