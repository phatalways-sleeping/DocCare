String mapMonth(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'July';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    default:
      return 'Dec';
  }
}

String getPostFix(int day) {
  if (day == 1 || day == 21 || day == 31) {
    return 'st';
  } else if (day == 2 || day == 22) {
    return 'nd';
  } else if (day == 3 || day == 23) {
    return 'rd';
  } else {
    return 'th';
  }
}