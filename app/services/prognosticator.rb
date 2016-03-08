class Prognosticator
  attr_accessor :user, :event

  def initialize(user:, event:)
    @user, @event = user, event
  end

  def calculate_user_reliability
    query = <<-SQL
      historical = false
      AND waitlist_position IS NOT NULL
      AND rsvp_sessions.name !~* 'install\s?fest'
      AND rsvps.role_id = ?
    SQL

    rsvps = user.rsvps.includes(:rsvp_sessions).where(query, Role::ORGANIZER.id)

    total = 0
    checked_in = 0

    rsvps.each do |rsvp|
      checked_in += rsvp.rsvp_sessions.select { |session| session.checked_in }.length
      total += rsvp.rsvp_sessions.count
    end

    checked_in / total
  end

  def calculate_event_attendance

  end

  private
end

blah.include(:rsvp_sessions).where(condition)