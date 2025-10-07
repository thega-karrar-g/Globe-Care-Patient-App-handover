enum Speed { slow, normal, fast }

extension SpeedExtensionForScroll on Speed {
  Duration get moveDuration {
    switch (this) {
      case Speed.slow:
        return Duration(milliseconds: 1000);
      case Speed.normal:
        return Duration(milliseconds: 800);
      case Speed.fast:
        return Duration(milliseconds: 300);
    }
  }
}

extension SpeedExtensionForAlternate on Speed {
  Duration get animationDuration {
    switch (this) {
      case Speed.slow:
        return Duration(milliseconds: 9000);
      case Speed.normal:
        return Duration(milliseconds: 9000);
      case Speed.fast:
        return Duration(milliseconds: 9000);
    }
  }

  Duration get backDuration {
    return animationDuration;
  }

  Duration get pauseDuration {
    return animationDuration;
  }
}
