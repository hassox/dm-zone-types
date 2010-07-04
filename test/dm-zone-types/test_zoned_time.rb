require 'test/test_helper'

context do
  setup do
    DataMapper.auto_migrate!
  end

  test do
    assert "The gem constant is defined" do
      defined?(DataMapper::Zone::Types)
    end

    %w(Lima Greenland UTC).each do |saved_tz|
      %w(Melbourne Wellington Hawaii).each do |tz|
        # #typecast
        context do
          setup do
            Time.zone = tz
            DataMapper::Zone::Types.storage_zone = saved_tz
            @table_name = SpecModel.storage_names[:default]
          end

          # should be nil when not set
          test do
            SpecModel.new.zoned_time.must == nil
          end

          # should typecast to a DateTime from a string
          test do
            model = SpecModel.new(:zoned_time => "2009-12-13 12:13:14")

            assert { model.zoned_time.kind_of?(ActiveSupport::TimeWithZone) }

            model.zoned_time.year.must   == 2009
            model.zoned_time.month.must  == 12
            model.zoned_time.day.must    == 13
            model.zoned_time.hour.must   == 12
            model.zoned_time.min.must    == 13
            model.zoned_time.sec.must    == 14
          end

          # Should take a date in any time zone and convert it to the set time zone
          test do
            this_timezone = Time.zone.now
            t = nil
            Time.use_zone("Budapest"){
              t = Time.zone.now
            }
            model = SpecModel.new(:zoned_time => t)
            model.zoned_time.zone.must == this_timezone.zone
          end

          # should typecast to a DateTime from a time
          test do
            t = Time.zone.now

            model = SpecModel.new(:zoned_time => t)
            assert { model.save }
            assert { model.zoned_time.kind_of?(ActiveSupport::TimeWithZone) }
            assert { model.zoned_time.zone == t.zone }

            sql = "SELECT * FROM \"#{@table_name}\""
            r = repository.adapter.select(sql)

            saved = DateTime.parse(r.first.zoned_time)
            zoned = ActiveSupport::TimeZone[saved_tz].parse(r.first.zoned_time)
            saved.year.must   == zoned.year
            saved.month.must  == zoned.month
            saved.day.must    == zoned.day
            saved.hour.must   == zoned.hour
            saved.min.must    == zoned.min
            saved.sec.must    == zoned.sec
            saved.utc_offset.must == zoned.utc_offset

            repository.identity_map(SpecModel).clear
            model = SpecModel.first
            model.zoned_time.zone.must == t.zone
          end

          # should typecast to a DateTime from a date
          test do
            d = Date.today
            model = SpecModel.new(:zoned_time => d)
            assert { model.zoned_time.kind_of?(ActiveSupport::TimeWithZone) }
          end
        end
      end # tz's
    end # saved_tz's
  end
end
