#!zsh -e

widget_path=~/Library/Application\ Support/Übersicht/widgets

# Remove standard widget
rm -rf $widget_path/*

# Install Morning
morning_url=https://raw.githubusercontent.com/imRohan/ubersicht-morning.widget/master/morning.widget.zip
morning_zip=/tmp/morning.widget.zip
wget --quiet --output-document=$morning_zip $morning_url
unzip -qq $morning_zip -d $widget_path

# Install Calendar
calendar_url=https://raw.githubusercontent.com/felixhageloh/uebersicht-widgets/master/calendar/calendar.widget.zip
calendar_zip=/tmp/calendar.widget.zip
wget --quiet --output-document=$calendar_zip $calendar_url
unzip -qq $calendar_zip -d $widget_path
