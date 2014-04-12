public class ChartController2 {

    public List<Opportunity> getOpportunities() {
         return [SELECT Name, Type, Amount, CloseDate FROM Opportunity order by Amount asc limit 10];
    }
    
    public List<PieWedgeData> getAccountAggregate() {
        List<PieWedgeData> data = new List<PieWedgeData>();
        for(AggregateResult ar : [SELECT Account.Name, Count(Id)idcnt, SUM(Amount)suma, SUM(ExpectedRevenue)sumer FROM Opportunity Group By Account.Name]) {
            data.add(new PieWedgeData(String.valueOf(ar.get('Name')), Integer.valueOf(ar.get('suma'))));
        }
        return data;
    }
    
    // Return a list of data points for a chart
    public List<Data> getData() {
        return ChartController2.getChartData();
    }
    
    // Make the chart data available via JavaScript remoting
    @RemoteAction
    public static List<Data> getRemoteData() {
        return ChartController2.getChartData();
    }

    // The actual chart data; needs to be static to be
    // called by a @RemoteAction method
    public static List<Data> getChartData() {
        List<Data> data = new List<Data>();
        data.add(new Data('Jan', 30, 90, 55));
        data.add(new Data('Feb', 44, 15, 65));
        data.add(new Data('Mar', 25, 32, 75));
        //data.add(new Data('Apr', 74, 28, 85));
        //data.add(new Data('May', 65, 51, 95));
        //data.add(new Data('Jun', 33, 45, 99));
        //data.add(new Data('Jul', 92, 82, 30));
        //data.add(new Data('Aug', 87, 73, 45));
        //data.add(new Data('Sep', 34, 65, 55));
        //data.add(new Data('Oct', 78, 66, 56));
        //data.add(new Data('Nov', 80, 67, 53));
        //data.add(new Data('Dec', 17, 70, 70));
        return data;
    }
    
    // Wrapper class
    public class Data {
        public String name { get; set; }
        public Integer data1 { get; set; }
        public Integer data2 { get; set; }
        public Integer data3 { get; set; }
        public Data(String name, Integer data1, Integer data2, Integer data3) {
            this.name = name;
            this.data1 = data1;
            this.data2 = data2;
            this.data3 = data3;
        }
    }
    
    public List<PieWedgeData> getPieData() {
        List<PieWedgeData> data = new List<PieWedgeData>();
        data.add(new PieWedgeData('Jan', 30));
        data.add(new PieWedgeData('Feb', 15));
        data.add(new PieWedgeData('Mar', 10));
        data.add(new PieWedgeData('Apr', 20));
        data.add(new PieWedgeData('May', 20));
        data.add(new PieWedgeData('Jun', 5));
        return data;
    }

    // Wrapper class
    public class PieWedgeData {

        public String name { get; set; }
        public Integer data { get; set; }

        public PieWedgeData(String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
}