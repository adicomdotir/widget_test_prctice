List<int> getPrimeFactors(int num) {
  final primes = <int>[];
  int candidate = 2;

  while (num > 1) {
    while (num % candidate == 0) {
      primes.add(candidate);
      num = num ~/ candidate;
    }
    candidate++;
  }
  return primes;
}
