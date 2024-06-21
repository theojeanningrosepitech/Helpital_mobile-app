part of values;

enum Filter {
  appareilMedical,
  outilMedical,
  medicalDevice,
  surgeryTool
}


void displayListOfObject(String arg, List obj) {
  obj.forEach((element) => print(inspect(element)));
}

List<String> listPage = [
  'planning',
  'patient',
  'inventory',
  'directory',
  'plan',
  'meeting',
  'rooms',
  'note',
  'waitingRoom',
  'scanner',
];