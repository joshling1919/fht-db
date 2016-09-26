# == Schema Information
#
# Table name: players
#
#  id                   :integer          not null, primary key
#  esbid                :string
#  gsisPlayerId         :string
#  firstName            :string
#  lastName             :string
#  teamAbbr             :string
#  opponentTeamAbbr     :string
#  position             :string
#  percentOwned         :float
#  percentOwnedChange   :float
#  percentStarted       :float
#  percentStartedChange :float
#  depthChartOrder      :integer
#  numAdds              :integer
#  numDrops             :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Player < ActiveRecord::Base
end
