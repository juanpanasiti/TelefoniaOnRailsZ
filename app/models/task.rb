class Task < ApplicationRecord
  ####### VALIDATIONS
  validates_presence_of :name, :state, :type_task
  validates_uniqueness_of :name
  ####### SCOPES
  scope :fresh, -> { where(state: 'Nueva')}
  scope :pending, -> { where(state: 'Pendiente')  }
  scope :in_feedback, -> { where(state: 'Feedback')  }
  scope :finished_ok, -> { where(state: 'Terminada OK')  }
  scope :finished_fail, -> { where(state: 'Terminada Fail')  }
  ####### CLASS METHODS
  def self.get_type_options
    options = ['Celular','Fijo','Administrativa','Otra']
    return options
  end

  def self.get_state_options
    options = ['Nueva','Pendiente','Feedback','Terminada OK','Terminada Fail']
    return options
  end
end
