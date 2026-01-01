# Screen 37: Revenue Analytics

## Overview

- **Screen ID**: 37
- **Screen Name**: Revenue Analytics
- **User Role**: Admin
- **Platform**: Web (Desktop)
- **Navigation**:
  - From: Admin Dashboard (Screen 30) → Tap "Revenue"
  - From: Sidebar → "Analytics" → "Revenue"

## ASCII Wireframe

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ ☰  UrbanNest Admin          Revenue Analytics                    👤 Admin  │ Header
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  📊 Revenue Analytics                                                       │
│                                                                             │
│  ┌──────────┬──────────┬──────────┬──────────┐                            │
│  │ Today ▼  │ All Cities ▼ │ All Services ▼ │ [Export] │                  │ Filters
│  └──────────┴──────────┴──────────┴──────────┘                            │
│                                                                             │
│  ┌─────────────────┬─────────────────┬─────────────────┬─────────────────┐│
│  │ Total Revenue   │ Completed       │ Commission      │ Net Earnings    ││ KPI Cards
│  │ ₹ 12,45,000     │ ₹ 10,50,000     │ ₹ 1,95,000      │ ₹ 10,50,000     ││
│  │ ↑ 15.2% vs last │ ↑ 12.8%         │ ↑ 18.5%         │ ↑ 13.2%         ││
│  └─────────────────┴─────────────────┴─────────────────┴─────────────────┘│
│                                                                             │
│  ───── Revenue Trend ─────                                                 │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐ │
│  │ ₹15L                                                                  │ │ Line Chart
│  │      ╱╲                                                               │ │
│  │     ╱  ╲       ╱╲                                                     │ │
│  │ ₹10L    ╲     ╱  ╲    ╱╲                                              │ │
│  │          ╲   ╱    ╲  ╱  ╲                                             │ │
│  │ ₹5L       ╲ ╱      ╲╱    ╲                                            │ │
│  │            ╲╱              ╲                                           │ │
│  │ ₹0 ─────────────────────────────────────────                          │ │
│  │    Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec        │ │
│  │                                                                        │ │
│  │    ─ Gross Revenue    ─ Net Revenue    ─ Commission                  │ │
│  └───────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│  ───── Breakdown ─────                                                     │
│                                                                             │
│  ┌─────────────────────────────┬───────────────────────────────────────┐  │
│  │ Revenue by Service Category │ Revenue by City                       │  │
│  │                             │                                       │  │
│  │  🔧 Home Services    42%    │  Delhi NCR         ₹ 4,50,000  36%   │  │
│  │  ████████████████████       │  ████████████████████████            │  │
│  │                             │                                       │  │
│  │  🧹 Cleaning         28%    │  Mumbai            ₹ 3,20,000  26%   │  │
│  │  ██████████████             │  ████████████████                    │  │
│  │                             │                                       │  │
│  │  ⚡ Electrical       18%    │  Bangalore         ₹ 2,80,000  22%   │  │
│  │  ██████████                 │  ██████████████                      │  │
│  │                             │                                       │  │
│  │  🚿 Plumbing         12%    │  Hyderabad         ₹ 1,95,000  16%   │  │
│  │  ██████                     │  ██████████                          │  │
│  └─────────────────────────────┴───────────────────────────────────────┘  │
│                                                                             │
│  ───── Revenue Table ─────                                                 │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐ │
│  │ Date       │ Bookings │ Gross Revenue │ Commission │ Net Revenue  │   │ │
│  ├───────────────────────────────────────────────────────────────────────┤ │
│  │ Dec 31     │    145   │  ₹ 65,000     │ ₹ 12,350   │ ₹ 52,650     │ ↓ │ │
│  │ Dec 30     │    132   │  ₹ 58,500     │ ₹ 11,115   │ ₹ 47,385     │   │ │
│  │ Dec 29     │    156   │  ₹ 72,000     │ ₹ 13,680   │ ₹ 58,320     │   │ │
│  │ Dec 28     │    128   │  ₹ 55,200     │ ₹ 10,488   │ ₹ 44,712     │   │ │
│  │ Dec 27     │    142   │  ₹ 62,800     │ ₹ 11,932   │ ₹ 50,868     │   │ │
│  └───────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Key Features

### 1. Date Range Filter
- Predefined ranges:
  - Today
  - Yesterday
  - Last 7 Days
  - Last 30 Days
  - This Month
  - Last Month
  - Custom Range (date picker)
- Default: Last 30 Days

### 2. Advanced Filters
- **City Filter**: All Cities, or specific city
- **Service Filter**: All Services, or specific category
- **Provider Type**: All, Individual, Company
- Apply/Reset buttons

### 3. KPI Cards
- **Total Revenue**: Gross revenue before commission
- **Completed Bookings Revenue**: Revenue from completed bookings only
- **Commission**: Platform commission earned
- **Net Earnings**: Provider payouts
- Percentage change vs. previous period
- Color-coded indicators (green ↑, red ↓)

### 4. Revenue Trend Chart
- Line chart with 3 series:
  - Gross Revenue (teal)
  - Net Revenue (blue)
  - Commission (orange)
- Time granularity based on date range:
  - 1-7 days: Hourly
  - 8-30 days: Daily
  - 31-90 days: Weekly
  - 90+ days: Monthly
- Hover tooltips with exact values
- Zoom and pan controls

### 5. Revenue Breakdown
- **By Service Category**: Horizontal bar chart with percentages
- **By City**: Horizontal bar chart with amounts and percentages
- Top 5 in each category
- "View All" link for complete breakdown

### 6. Revenue Table
- Daily revenue summary
- Columns:
  - Date
  - Number of Bookings
  - Gross Revenue
  - Commission
  - Net Revenue
- Sortable columns
- Pagination (20 rows per page)
- Export to CSV/Excel

### 7. Export Functionality
- Export as CSV
- Export as Excel
- Export as PDF (with charts)
- Email report
- Schedule recurring reports

## Component Breakdown

```typescript
// components/admin/RevenueAnalytics.tsx
'use client'

import React, { useState, useEffect } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Button } from '@/components/ui/button'
import { LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts'
import { Download, TrendingUp, TrendingDown } from 'lucide-react'

interface RevenueData {
  totalRevenue: number
  completedRevenue: number
  commission: number
  netEarnings: number
  percentChange: {
    totalRevenue: number
    completedRevenue: number
    commission: number
    netEarnings: number
  }
  trendData: Array<{
    date: string
    grossRevenue: number
    netRevenue: number
    commission: number
  }>
  serviceBreakdown: Array<{
    category: string
    amount: number
    percentage: number
  }>
  cityBreakdown: Array<{
    city: string
    amount: number
    percentage: number
  }>
  dailyRevenue: Array<{
    date: string
    bookings: number
    grossRevenue: number
    commission: number
    netRevenue: number
  }>
}

export default function RevenueAnalytics() {
  const [dateRange, setDateRange] = useState('last_30_days')
  const [cityFilter, setCityFilter] = useState('all')
  const [serviceFilter, setServiceFilter] = useState('all')
  const [data, setData] = useState<RevenueData | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetchRevenueData()
  }, [dateRange, cityFilter, serviceFilter])

  const fetchRevenueData = async () => {
    setLoading(true)
    try {
      const response = await fetch('/api/admin/analytics/revenue', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ dateRange, cityFilter, serviceFilter })
      })
      const result = await response.json()
      setData(result.data)
    } catch (error) {
      console.error('Failed to fetch revenue data:', error)
    } finally {
      setLoading(false)
    }
  }

  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-IN', {
      style: 'currency',
      currency: 'INR',
      minimumFractionDigits: 0
    }).format(amount)
  }

  const exportData = async (format: 'csv' | 'excel' | 'pdf') => {
    try {
      const response = await fetch('/api/admin/analytics/revenue/export', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ dateRange, cityFilter, serviceFilter, format })
      })
      const blob = await response.blob()
      const url = window.URL.createObjectURL(blob)
      const a = document.createElement('a')
      a.href = url
      a.download = `revenue_report_${Date.now()}.${format}`
      a.click()
    } catch (error) {
      console.error('Export failed:', error)
    }
  }

  if (loading) {
    return <div className="flex items-center justify-center h-screen">Loading...</div>
  }

  if (!data) {
    return <div>No data available</div>
  }

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <h1 className="text-3xl font-bold">📊 Revenue Analytics</h1>
        <div className="flex gap-2">
          <Button onClick={() => exportData('csv')} variant="outline">
            <Download className="w-4 h-4 mr-2" />
            Export CSV
          </Button>
          <Button onClick={() => exportData('excel')} variant="outline">
            Export Excel
          </Button>
          <Button onClick={() => exportData('pdf')} variant="outline">
            Export PDF
          </Button>
        </div>
      </div>

      {/* Filters */}
      <div className="flex gap-4">
        <Select value={dateRange} onValueChange={setDateRange}>
          <SelectTrigger className="w-[200px]">
            <SelectValue placeholder="Select date range" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="today">Today</SelectItem>
            <SelectItem value="yesterday">Yesterday</SelectItem>
            <SelectItem value="last_7_days">Last 7 Days</SelectItem>
            <SelectItem value="last_30_days">Last 30 Days</SelectItem>
            <SelectItem value="this_month">This Month</SelectItem>
            <SelectItem value="last_month">Last Month</SelectItem>
            <SelectItem value="custom">Custom Range</SelectItem>
          </SelectContent>
        </Select>

        <Select value={cityFilter} onValueChange={setCityFilter}>
          <SelectTrigger className="w-[200px]">
            <SelectValue placeholder="Select city" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Cities</SelectItem>
            <SelectItem value="delhi">Delhi NCR</SelectItem>
            <SelectItem value="mumbai">Mumbai</SelectItem>
            <SelectItem value="bangalore">Bangalore</SelectItem>
            <SelectItem value="hyderabad">Hyderabad</SelectItem>
          </SelectContent>
        </Select>

        <Select value={serviceFilter} onValueChange={setServiceFilter}>
          <SelectTrigger className="w-[200px]">
            <SelectValue placeholder="Select service" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Services</SelectItem>
            <SelectItem value="home_services">Home Services</SelectItem>
            <SelectItem value="cleaning">Cleaning</SelectItem>
            <SelectItem value="electrical">Electrical</SelectItem>
            <SelectItem value="plumbing">Plumbing</SelectItem>
          </SelectContent>
        </Select>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-4 gap-4">
        <KPICard
          title="Total Revenue"
          value={formatCurrency(data.totalRevenue)}
          change={data.percentChange.totalRevenue}
          changeLabel="vs last period"
        />
        <KPICard
          title="Completed Bookings"
          value={formatCurrency(data.completedRevenue)}
          change={data.percentChange.completedRevenue}
          changeLabel="vs last period"
        />
        <KPICard
          title="Commission"
          value={formatCurrency(data.commission)}
          change={data.percentChange.commission}
          changeLabel="vs last period"
        />
        <KPICard
          title="Net Earnings"
          value={formatCurrency(data.netEarnings)}
          change={data.percentChange.netEarnings}
          changeLabel="vs last period"
        />
      </div>

      {/* Revenue Trend Chart */}
      <Card>
        <CardHeader>
          <CardTitle>Revenue Trend</CardTitle>
        </CardHeader>
        <CardContent>
          <ResponsiveContainer width="100%" height={300}>
            <LineChart data={data.trendData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="date" />
              <YAxis />
              <Tooltip formatter={(value) => formatCurrency(value as number)} />
              <Legend />
              <Line type="monotone" dataKey="grossRevenue" stroke="#0D7377" strokeWidth={2} name="Gross Revenue" />
              <Line type="monotone" dataKey="netRevenue" stroke="#14B8A6" strokeWidth={2} name="Net Revenue" />
              <Line type="monotone" dataKey="commission" stroke="#FF6B35" strokeWidth={2} name="Commission" />
            </LineChart>
          </ResponsiveContainer>
        </CardContent>
      </Card>

      {/* Breakdown Charts */}
      <div className="grid grid-cols-2 gap-4">
        <Card>
          <CardHeader>
            <CardTitle>Revenue by Service Category</CardTitle>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={250}>
              <BarChart data={data.serviceBreakdown} layout="vertical">
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis type="number" />
                <YAxis dataKey="category" type="category" />
                <Tooltip formatter={(value) => formatCurrency(value as number)} />
                <Bar dataKey="amount" fill="#0D7377" />
              </BarChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Revenue by City</CardTitle>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={250}>
              <BarChart data={data.cityBreakdown} layout="vertical">
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis type="number" />
                <YAxis dataKey="city" type="category" />
                <Tooltip formatter={(value) => formatCurrency(value as number)} />
                <Bar dataKey="amount" fill="#FF6B35" />
              </BarChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      </div>

      {/* Revenue Table */}
      <Card>
        <CardHeader>
          <CardTitle>Daily Revenue Summary</CardTitle>
        </CardHeader>
        <CardContent>
          <table className="w-full">
            <thead>
              <tr className="border-b">
                <th className="text-left p-2">Date</th>
                <th className="text-right p-2">Bookings</th>
                <th className="text-right p-2">Gross Revenue</th>
                <th className="text-right p-2">Commission</th>
                <th className="text-right p-2">Net Revenue</th>
              </tr>
            </thead>
            <tbody>
              {data.dailyRevenue.map((row, index) => (
                <tr key={index} className="border-b hover:bg-gray-50">
                  <td className="p-2">{row.date}</td>
                  <td className="text-right p-2">{row.bookings}</td>
                  <td className="text-right p-2">{formatCurrency(row.grossRevenue)}</td>
                  <td className="text-right p-2">{formatCurrency(row.commission)}</td>
                  <td className="text-right p-2">{formatCurrency(row.netRevenue)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </CardContent>
      </Card>
    </div>
  )
}

function KPICard({ title, value, change, changeLabel }: {
  title: string
  value: string
  change: number
  changeLabel: string
}) {
  const isPositive = change >= 0

  return (
    <Card>
      <CardHeader className="pb-2">
        <CardTitle className="text-sm font-medium text-gray-600">{title}</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="text-2xl font-bold">{value}</div>
        <div className={`flex items-center text-sm ${isPositive ? 'text-green-600' : 'text-red-600'}`}>
          {isPositive ? <TrendingUp className="w-4 h-4 mr-1" /> : <TrendingDown className="w-4 h-4 mr-1" />}
          {Math.abs(change)}% {changeLabel}
        </div>
      </CardContent>
    </Card>
  )
}
```

## API Integration

### Get Revenue Analytics
```
POST /api/admin/analytics/revenue

Request:
{
  "dateRange": "last_30_days",
  "cityFilter": "all",
  "serviceFilter": "all",
  "startDate": "2025-12-01", // if custom range
  "endDate": "2025-12-31"
}

Response:
{
  "success": true,
  "data": {
    "totalRevenue": 1245000,
    "completedRevenue": 1050000,
    "commission": 195000,
    "netEarnings": 1050000,
    "percentChange": {
      "totalRevenue": 15.2,
      "completedRevenue": 12.8,
      "commission": 18.5,
      "netEarnings": 13.2
    },
    "trendData": [
      {
        "date": "2025-12-01",
        "grossRevenue": 45000,
        "netRevenue": 38250,
        "commission": 6750
      }
    ],
    "serviceBreakdown": [
      {
        "category": "Home Services",
        "amount": 523800,
        "percentage": 42
      }
    ],
    "cityBreakdown": [
      {
        "city": "Delhi NCR",
        "amount": 450000,
        "percentage": 36
      }
    ],
    "dailyRevenue": [
      {
        "date": "Dec 31",
        "bookings": 145,
        "grossRevenue": 65000,
        "commission": 12350,
        "netRevenue": 52650
      }
    ]
  }
}
```

### Export Revenue Report
```
POST /api/admin/analytics/revenue/export

Request:
{
  "dateRange": "last_30_days",
  "cityFilter": "all",
  "serviceFilter": "all",
  "format": "excel" // or "csv", "pdf"
}

Response: File download (binary)
```

## Testing Checklist

- [ ] Date range filter updates data
- [ ] City filter works correctly
- [ ] Service filter works correctly
- [ ] KPI cards display correct values
- [ ] Percentage changes calculate correctly
- [ ] Line chart renders with all series
- [ ] Bar charts display top 5 items
- [ ] Revenue table sorts correctly
- [ ] Pagination works
- [ ] CSV export downloads
- [ ] Excel export downloads
- [ ] PDF export downloads
- [ ] Real-time data updates
- [ ] Responsive layout on different screen sizes

## Design Notes

### Chart Libraries
- Recharts for React charts
- Chart.js alternative
- D3.js for custom charts

### Performance
- Lazy load charts
- Debounce filter changes
- Cache API responses
- Virtualize large tables

### Accessibility
- Keyboard navigation
- ARIA labels for charts
- Screen reader support for data tables

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platform**: Web (Next.js)
