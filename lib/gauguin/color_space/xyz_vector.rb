module Gauguin
  module ColorSpace
    class XyzVector < Vector
      WHITE_REFERENCE = self[95.047, 100.000, 108.883]

      EPSILON = 0.008856
      KAPPA = 903.3

      def to_lab
        zipped = self.zip(XyzVector::WHITE_REFERENCE)
        x, y, z = zipped.map do |component, white_component|
          component / white_component
        end

        l = 116 * f(y) - 16
        a = 500 * (f(x) - f(y))
        b = 200 * (f(y) - f(z))

        LabVector[l, a, b]
      end

      private

      def f(x)
        if x > EPSILON
          x ** (1.0/3.0)
        else
          (KAPPA * x + 16.0) / 116.0
        end
      end
    end
  end
end
