import 'dart:core';
import 'dart:math';

void main() {
  //basic for loop
  int n = 4;
  for (int i = 0; i < n; i++) {
    print('$i');
  }

  //print asterisk triangle
  for (int i = 0; i <= n; i++) {
    print('*' * i);
  }

  //print inverted and indented triangle
  for (int i = (n - 1); i >= 0; i--) {
    print("    *********".substring(i, 5 + 2 * i));
  }

  int getGaps(List<String> binaryArray, List<int> gaps) {
    // finding the first one via its index
    final firstOne = binaryArray.indexOf("1");
    if (firstOne > -1) {
      // new list created taking a slice of original list
      // from the index of the firstOne + 1 index
      final newBinaryArray = binaryArray.sublist(firstOne + 1);
      // finding second one via its index in new list slice
      final secondOne = newBinaryArray.indexOf("1");
      // accounting for no zeros
      if (secondOne > 0) {
        // adding 2 to our gaps list
        gaps.add(secondOne);
      }

      // Pass list minus second one and gaps list
      return getGaps(newBinaryArray.sublist(secondOne + 1), gaps);
    }

    // if gaps list length is empty return 0
    // otherwise return largest value in list
    return (gaps.isNotEmpty) ? gaps.reduce((a, b) => (a > b) ? a : b) : 0;
  }

  //binary gap length checker
  int N = 15;

  int solution(int N) {
    //convert N to binary
    var binaryN = N.toRadixString(2);

    // print(binaryN);

    //remove zeroes off end of string
    while (binaryN.endsWith('0')) {
      binaryN = binaryN.substring(0, binaryN.length - 1);
    }
    //  print(binaryN);

    //split binary number by 1s to get the gaps
    final binaryArrayGaps =
        binaryN.split('1').where((e) => e.isNotEmpty).toList();
//print(binaryArrayGaps);
    // print(binaryArrayGaps.length);

    //identify longest string of zeroes and return
    int gapLength = 0;

    for (var i = 0; i < binaryArrayGaps.length; i++) {
      if (binaryArrayGaps[i].length > gapLength) {
        gapLength = binaryArrayGaps[i].length;
      }
      //   print(gapLength);
    }
    return gapLength;
  }

  int result = solution(N);
  print(result);

  //rotate an array to the right by int K
  List<int> A = [1, 2, 3, 4, 5, 6, 7];
  int K = 2;

  List<int> rotationSolution(List<int> A, int K) {
    int N = A.length;

    if (A.isEmpty) {
      return A;
    }

    // If K is greater than N, reduce it to the effective number of rotations
    K = K % N;

    // If no rotations needed or the array is empty, return the original array
    if (K == 0 || N == 0) {
      return A;
    }

    // Create a new list to store the rotated elements
    List<int> rotated = List<int>.filled(N, 0);

    // Rotate the array by shifting elements to the right K times
    for (int i = 0; i < N; i++) {
      rotated[(i + K) % N] = A[i];
    }

    return rotated;
  }

  var rotationResult = rotationSolution(A, K);
  print(rotationResult);

  String S =
      'John Doe; Peter Benjamin Parker; Mary Jane Watson-Parker; John Elvis Doe; John Evan Doe; Jane Doe; Peter Brian Parker';
  String C = 'Example';

  String emailSolution(String S, String C) {
    List<String> names = S.split("; ");
    String company = C.toLowerCase();
    Map<String, int> emailCounts = {};

    List<String> emails = [];

    String unformatName(String name) {
      List<String> parts = name.split(" ");
      String firstName = parts[0];
      String middleName = '';

      if (parts.length == 3) {
        middleName = parts[1];
      }

      String lastName = parts[parts.length - 1];
      if (parts.length == 3) {
        return "$firstName $middleName $lastName";
      } else {
        return "$firstName $lastName";
      }
    }

    String formatName(String name) {
      List<String> parts = name.split(" ");
      String firstName = parts[0];
      String lastName = parts[parts.length - 1];
      lastName = lastName.replaceAll("-", "");
      return "${lastName}_$firstName";
    }

    String generateEmail(String name) {
      String formattedName = formatName(name);
      String baseEmail = "$formattedName@$company.com";
      int count = emailCounts[formattedName] ?? 0;

      if (count > 0) {
        emailCounts[formattedName] = count + 1;
        return "$formattedName${count + 1}@$company.com";
      } else {
        emailCounts[formattedName] = 1;
        return baseEmail;
      }
    }

    for (String name in names) {
      String email = generateEmail(name).toLowerCase();
      String unformattedName = unformatName(name);
      String entry = "$unformattedName <$email>";
      emails.add(entry);
    }

    return emails.join("; ");
  }

  String emailResult = emailSolution(S, C);
  print(emailResult);
}
