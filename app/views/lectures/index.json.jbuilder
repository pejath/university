# frozen_string_literal: true

json.array! @lectures, partial: 'lectures/lecture', as: :lecture
