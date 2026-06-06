class Mission::Prerequisite < ApplicationRecord
  self.table_name = "mission_prerequisites"

  belongs_to :prerequisite_mission, class_name: "Mission"
  belongs_to :dependent_mission, class_name: "Mission"

  validates :prerequisite_mission_id, uniqueness: { scope: :dependent_mission_id }
end
