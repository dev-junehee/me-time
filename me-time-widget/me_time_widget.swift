//
//  me_time_widget.swift
//  me-time-widget
//
//  Created by junehee on 10/4/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    /// 데이터를 불러오기 전(getSnapshot)에 보여줄 placeholder
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    /// 위젯 갤러리에서 위젯을 고를 때 보이는 샘플 데이터를 보여줄때 해당 메소드 호출
    /// API를 통해서 데이터를 fetch하여 보여줄때 딜레이가 있는 경우 여기서 샘플 데이터를 하드코딩해서 보여주는 작업도 가능
    /// context.isPreview가 true인 경우 위젯 갤러리에 위젯이 표출되는 상태
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    /// 홈화면에 있는 위젯을 언제 업데이트 시킬것인지 구현하는 부분
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }
        
        /// (4시간뒤에 다시 타임라인을 새로 다시 불러옴)
        let timeline = Timeline(entries: entries, policy: .atEnd)
        /// `.atEnd`: 마지막 date가 끝난 후 타임라인 reloading
        /// `.after`: 다음 data가 지난 후 타임라인 reloading
        /// `.never`: 즉시 타임라인 reloading
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct me_time_widgetEntryView : View {
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry

    @ViewBuilder
    var body: some View {
        switch self.family {
        case .systemSmall:
            ZStack {
                Image("gradientBackground")
                    .widgetBackground()
                Text("ㅇㄹㅇㄹㅇㄹ")
            }
            .widgetURL(URL(string: getPercentEcododedString("widget://deeplink?text=\(text)")))
        case .systemMedium:
            Text(".systemMedium")
        case .systemLarge:
            Text(".systemLarge")
        case .systemExtraLarge: // iPad에서만 가능
            Text(".systemExtraLarge")
        default:
            Text("default")
        }
    }
    
    private func getPercentEcododedString(_ string: String) -> String {
        string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
}

struct me_time_widget: Widget {
    let kind: String = "me_time_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                me_time_widgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                me_time_widgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("모닝페이퍼")
        .description("빠르게 모닝페이퍼를 작성할 수 있어요.")
    }
}

extension View {
    func widgetBackground() -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                // ...
            }
        } else {
            return background()
        }
    }
}


#Preview(as: .systemSmall) {
    me_time_widget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}

