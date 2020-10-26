
/// Class representing the result for breaking a vigenere cipher
/// :param str key: the best key found by the breaker
/// :param float fitness: the fitness of the resulting plaintext
class BreakerResult {
  List<int> key;
  double fitness;

  BreakerResult({
    this.key = null,
    this.fitness = 0,
  });
}

BreakerResult break_vigenere (List<int> cipher_bin, int keyLength, List<List<int>> vigenereSquare, List<List<int>> bigrams) {
  var key = List<int>();
  var best_score_0   = 0;
  var best_key_ch1_0 = 0;
  //var best_key_ch2_0 = 0;
  var best_key_ch2 = 0;
   var max_fitness = 0;
  var prev_best_score = 0;
  var prev_best_key_ch2 = 0;

  for (var key_idx = 0; key_idx < keyLength; key_idx++) {
    max_fitness = 0;
    var best_key_ch1 = 0;
    best_key_ch2 = 0;
    for (var key_ch1 = 0; key_ch1 < 26; key_ch1++) {
      for (var key_ch2 = 0; key_ch2 < 26; key_ch2++) {
        var fitness = 0;
        for (var text_idx = key_idx; text_idx < (cipher_bin.length - 1); text_idx += keyLength) {
          var clear_ch1 = vigenereSquare[cipher_bin[text_idx  ]][key_ch1];
          var clear_ch2 = vigenereSquare[cipher_bin[text_idx+1]][key_ch2];
          fitness += bigrams[clear_ch1][clear_ch2];
        }
        if (fitness > max_fitness) {
          max_fitness = fitness;
          best_key_ch1 = key_ch1;
          best_key_ch2 = key_ch2;
        }
      }
    }
    if (key_idx == 0) {
      best_score_0   = max_fitness;
      best_key_ch1_0 = best_key_ch1;
      //best_key_ch2_0 = best_key_ch2;
      key.add(0); // just a placeholder
    } else {
      key.add((prev_best_score > max_fitness) ? prev_best_key_ch2 : best_key_ch1);
    }
    prev_best_score = max_fitness;
    prev_best_key_ch2 = best_key_ch2;
  }
  key[0] = (max_fitness > best_score_0) ? best_key_ch2 : best_key_ch1_0 ;

  return BreakerResult(
      key: key,
      fitness: max_fitness.toDouble(),
  );
}

