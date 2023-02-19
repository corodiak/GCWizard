part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

bool insideSectionItem(String currentLine) {
  if (RegExp(r'( Wherigo.ZItem\()').hasMatch(currentLine) ||
      RegExp(r'( Wherigo.ZTask\()').hasMatch(currentLine) ||
      RegExp(r'(.ZVariables =)').hasMatch(currentLine) ||
      RegExp(r'( Wherigo.ZTimer\()').hasMatch(currentLine) ||
      RegExp(r'( Wherigo.ZInput\()').hasMatch(currentLine) ||
      RegExp(r'(function)').hasMatch(currentLine)) {
    return false;
  }
  return true;
}

void analyzeAndExtractItemSectionData(List<String> lines) {
  for (int i = 0; i < lines.length; i++) {
    lines[i] = lines[i].trim();
    if (lines[i].trim().startsWith(LUAname + 'Container =')) {
      container = getContainer(lines[i]);
    }

    if (lines[i].trim().startsWith(LUAname + '.Id')) {
      id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].trim().startsWith(LUAname + '.Name')) {
      name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].trim().startsWith(LUAname + '.Description')) {
      description = '';
      sectionDescription = true;
      do {
        description = description + lines[i];
        if (i > lines.length - 2 || lines[i + 1].trim().startsWith(LUAname + '.Visible')) {
          sectionDescription = false;
        }
        i++;
        lines[i] = lines[i].trim();
      } while (sectionDescription);
      description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
      description = getLineData(description, LUAname, 'Description', obfuscatorFunction, obfuscatorTable).trim();
    }

    if (lines[i].trim().startsWith(LUAname + '.Visible'))
      visible = getLineData(lines[i], LUAname, 'Visible', obfuscatorFunction, obfuscatorTable);

    if (lines[i].trim().startsWith(LUAname + '.Media'))
      media = getLineData(lines[i], LUAname, 'Media', obfuscatorFunction, obfuscatorTable).trim();

    if (lines[i].trim().startsWith(LUAname + '.Icon'))
      icon = getLineData(lines[i], LUAname, 'Icon', obfuscatorFunction, obfuscatorTable);

    if (lines[i].trim().startsWith(LUAname + '.Locked'))
      locked = getLineData(lines[i], LUAname, 'Locked', obfuscatorFunction, obfuscatorTable);

    if (lines[i].trim().startsWith(LUAname + '.Opened')) {
      opened = getLineData(lines[i], LUAname, 'Opened', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].trim().startsWith(LUAname + '.ObjectLocation')) {
      location =
          lines[i].trim().replaceAll(LUAname + '.ObjectLocation', '').replaceAll(' ', '').replaceAll('=', '');
      if (location.endsWith('INVALID_ZONEPOINT'))
        location = '';
      else if (location.startsWith('ZonePoint')) {
        location = location.replaceAll('ZonePoint(', '').replaceAll(')', '').replaceAll(' ', '');
        zonePoint = WherigoZonePoint(double.parse(location.split(',')[0]), double.parse(location.split(',')[1]),
            double.parse(location.split(',')[2]));
        location = 'ZonePoint';
      } else
        location = getLineData(lines[i], LUAname, 'ObjectLocation', obfuscatorFunction, obfuscatorTable);
    }
  }
}
