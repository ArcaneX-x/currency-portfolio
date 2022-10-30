require '../lib/portfolio'
require '../lib/course_reader'
require 'byebug'

describe CourseReader do
  describe '#from_xml' do
    before do
      open_url = File.open("#{__dir__}/fixtures/course.xml")
      allow(described_class).to receive(:open_url).and_return open_url
    end
      it 'should be course_reader class' do
        courses = described_class.from_xml

        expect(courses).to be_an CourseReader
      end

    it 'should be return correct data' do
      courses = described_class.from_xml

      expect(courses.date).to eq '28.10.2022'
      expect(courses.usd_rate).to eq 61.3589
      expect(courses.eur_rate).to eq 61.5718
    end
  end


