package com.example.covid_ec;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Color;
import android.os.Bundle;
import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.components.YAxis;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.github.mikephil.charting.utils.ColorTemplate;

import java.util.ArrayList;

public class activity_stadistics extends AppCompatActivity {
    LineChart lineChart;
    LineData lineData;
    LineDataSet lineDataSet;
    ArrayList lineEntries;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_stadistics);
        lineChart = findViewById(R.id.lineChart);
        getEntries();
        lineDataSet = new LineDataSet(lineEntries, "");
        lineData = new LineData(lineDataSet);

        lineChart.setData(lineData);
        lineChart.getAxis(YAxis.AxisDependency.LEFT).setAxisMaximum(40f);
        lineChart.getAxis(YAxis.AxisDependency.LEFT).setAxisMinimum(35f);
        lineDataSet.setColors(ColorTemplate.JOYFUL_COLORS);
        lineDataSet.setValueTextColor(Color.BLACK);
        lineDataSet.setValueTextSize(18f);
    }

    private void getEntries() {
        lineEntries = new ArrayList<>();
        lineEntries.add(new Entry(5f, 36));
        lineEntries.add(new Entry(6f, 37));
        lineEntries.add(new Entry(7f, 38));
        lineEntries.add(new Entry(8f, 39));
        lineEntries.add(new Entry(10f, 37));
        lineEntries.add(new Entry(11f, 36));
        lineEntries.add(new Entry(16f, 37));
        lineEntries.add(new Entry(17f, 38));
        lineEntries.add(new Entry(20f, 36));


        /*lineEntries.add(new Entry(8f, 3));
        lineEntries.add(new Entry(7f, 4));
        lineEntries.add(new Entry(3f, 3));*/
    }
}
