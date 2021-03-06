# This file is part of Mconf-Web, a web application that provides access
# to the Mconf webconferencing system. Copyright (C) 2010-2015 Mconf.
#
# This file is licensed under the Affero General Public License version
# 3 or later. See the LICENSE file.

# Taken from: http://cbpowell.wordpress.com/2013/08/09/beautiful-logging-for-ruby-on-rails-4/
unless Rails.env == "development"
  class ActiveSupport::Logger::SimpleFormatter
    SEVERITY_TO_TAG_MAP     = {'DEBUG'=>'meh', 'INFO'=>'fyi', 'WARN'=>'hmm', 'ERROR'=>'wtf', 'FATAL'=>'omg', 'UNKNOWN'=>'???'}
    SEVERITY_TO_COLOR_MAP   = {'DEBUG'=>'0;37', 'INFO'=>'32', 'WARN'=>'33', 'ERROR'=>'31', 'FATAL'=>'31', 'UNKNOWN'=>'37'}
    USE_HUMOROUS_SEVERITIES = false

    def call(severity, time, progname, msg)
      if USE_HUMOROUS_SEVERITIES
        formatted_severity = sprintf("%-3s",SEVERITY_TO_TAG_MAP[severity])
      else
        formatted_severity = sprintf("%-5s",severity)
      end

      formatted_time = time.strftime("%Y-%m-%d %H:%M:%S.") << time.usec.to_s[0..2].rjust(3)
      color = SEVERITY_TO_COLOR_MAP[severity]

      "\033[0;37m#{formatted_time}\033[0m [\033[#{color}m#{formatted_severity}\033[0m] #{msg.strip} (pid:#{$$})\n"
    end
  end
end
