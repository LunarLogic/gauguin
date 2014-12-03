module Gauguin
  module ColorSpace
    class RgbVector < Vector
      MAX_VAUE = 255.0

      # Observer. = 2°, Illuminant = D65
      RGB_TO_XYZ = Matrix[[0.4124, 0.2126, 0.0193],
                          [0.3576, 0.7152, 0.1192],
                          [0.1805, 0.0722, 0.9505]]

      def pivot!
        self.each.with_index do |component, i|
          self[i] = pivot(component / MAX_VAUE)
        end
        self
      end

      def to_xyz
        self.pivot!
        matrix = Matrix[self] * RGB_TO_XYZ
        XyzVector[*matrix.row_vectors.first.to_a]
      end

      private

      def pivot(component)
        component = if component > 0.04045
          ((component + 0.055) / 1.055) ** 2.4
        else
          component / 12.92
        end
        component * 100.0
      end
    end
  end
end
