module Developers
  class Meta
    attr_reader :count

    private attr_reader :query

    def initialize(query:, count:)
      @query = query
      @count = count
    end

    def title
      components = []

      # i18n-tasks-use t("developers.meta.hire")
      components << i18n("hire")

      components << role_level if role_level

      # i18n-tasks-use t("developers.meta.freelance")
      components << i18n("independent") if freelance?

      # i18n-tasks-use t("developers.meta.ruby_on_rails_developers")
      components << i18n("professionals")

      # i18n-tasks-use t("developers.meta.in_state")
      components << i18n("in_state", state:) if state

      components.join(" ")
    end

    def description
      # i18n-tasks-use t("developers.meta.description")
      i18n("description", count:)
    end

    private

    def i18n(key, options = {})
      I18n.t(key, **options.merge(scope: "developers.meta"))
    end

    def role_level
      if query.role_levels.one?
        role = query.role_levels.first
        scope = [:activerecord, :attributes, :role_level]
        I18n.t(role, scope:, default: role.to_s.humanize).downcase
      end
    end

    def freelance?
      query.role_types.include?(:part_time_contract) &&
        query.role_types.include?(:full_time_contract) &&
        !query.role_types.include?(:full_time_employment)
    end

    def state
      if query.states.one?
        query.states.first
      end
    end
  end
end
