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

  ####### OBJECT METHODS
  def get_row_table_class
    state = self.state
    row_class = case self.state
      when 'Nueva' then 'bg-danger'
      when 'Pendiente' then 'table-danger'
      when 'Feedback' then 'table-warning'
      when 'Terminada OK' then 'table-success'
      when 'Terminada Fail' then 'table-secondary'
      else 'table-light'
    end
    return row_class
  end
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
