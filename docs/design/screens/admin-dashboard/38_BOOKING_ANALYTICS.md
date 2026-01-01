# Screen 38: Booking Analytics

## Overview

- **Screen ID**: 38
- **Screen Name**: Booking Analytics
- **User Role**: Admin
- **Platform**: Web (Desktop)
- **Navigation**:
  - From: Admin Dashboard (Screen 30) → Tap "Bookings"
  - From: Sidebar → "Analytics" → "Bookings"

## ASCII Wireframe

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ ☰  UrbanNest Admin         Booking Analytics                     👤 Admin  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  📅 Booking Analytics                                                       │
│                                                                             │
│  ┌──────────┬──────────┬──────────┬──────────┐                            │
│  │ Last 30 Days ▼ │ All Cities ▼ │ All Status ▼ │ [Export] │              │
│  └──────────┴──────────┴──────────┴──────────┘                            │
│                                                                             │
│  ┌──────────────┬──────────────┬──────────────┬──────────────┬──────────┐ │
│  │ Total        │ Completed    │ Cancelled    │ Pending      │ Success  │ │
│  │ Bookings     │ Bookings     │ Bookings     │ Bookings     │ Rate     │ │
│  │ 4,582        │ 3,845        │ 458          │ 279          │ 83.9%    │ │
│  │ ↑ 12.5%      │ ↑ 15.2%      │ ↓ 5.3%       │ ↓ 8.1%       │ ↑ 2.3%   │ │
│  └──────────────┴──────────────┴──────────────┴──────────────┴──────────┘ │
│                                                                             │
│  ───── Booking Trend ─────                                                 │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐ │
│  │ 200                                                                   │ │
│  │     ╱╲                                                                │ │
│  │    ╱  ╲      ╱╲                                                       │ │
│  │ 150    ╲    ╱  ╲    ╱╲                                                │ │
│  │         ╲  ╱    ╲  ╱  ╲                                               │ │
│  │ 100      ╲╱      ╲╱    ╲                                              │ │
│  │                         ╲                                             │ │
│  │  50 ─────────────────────────────────────────                         │ │
│  │     Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec       │ │
│  │                                                                        │ │
│  │     ─ Total    ─ Completed    ─ Cancelled    ─ Pending               │ │
│  └───────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│  ───── Booking Status Distribution ─────     ───── Peak Hours ─────        │
│                                                                             │
│  ┌──────────────────────────────┐  ┌──────────────────────────────────┐   │
│  │                              │  │ 250                              │   │
│  │    Completed  84%            │  │                    ▆▆▆           │   │
│  │    ████████████████████      │  │ 200        ▆▆▆    ███    ▆▆▆    │   │
│  │                              │  │           ████    ███    ███    │   │
│  │    Cancelled  10%            │  │ 150  ▆▆▆  ████    ███    ███    │   │
│  │    ████                      │  │     ████  ████    ███    ███    │   │
│  │                              │  │ 100 ████  ████    ███    ███    │   │
│  │    Pending     6%            │  │     ████  ████    ███    ███    │   │
│  │    ███                       │  │  50 ████  ████    ███    ███    │   │
│  │                              │  │     8AM   11AM    2PM     5PM    │   │
│  └──────────────────────────────┘  └──────────────────────────────────┘   │
│                                                                             │
│  ───── Top Services by Bookings ─────                                      │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐ │
│  │ Service              │ Bookings │ Completion Rate │ Avg Rating │ Trend││ │
│  ├───────────────────────────────────────────────────────────────────────┤ │
│  │ 🔧 AC Repair         │   856    │      92%        │   4.7 ⭐   │  ↑   ││ │
│  │ 🧹 Deep Cleaning     │   742    │      89%        │   4.8 ⭐   │  ↑   ││ │
│  │ ⚡ Electrical Work   │   628    │      95%        │   4.6 ⭐   │  →   ││ │
│  │ 🚿 Plumbing          │   512    │      88%        │   4.5 ⭐   │  ↓   ││ │
│  │ 🎨 Painting          │   486    │      91%        │   4.7 ⭐   │  ↑   ││ │
│  └───────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│  ───── Cancellation Analysis ─────                                         │
│                                                                             │
│  ┌────────────────────────────────────┬──────────────────────────────────┐ │
│  │ Cancellation Reasons               │ Cancelled by                     │ │
│  │                                    │                                  │ │
│  │  Provider not available      38%   │  Customer          65%           │ │
│  │  ████████████████████              │  ██████████████████████          │ │
│  │                                    │                                  │ │
│  │  Customer unavailable        25%   │  Provider          28%           │ │
│  │  █████████████                     │  ████████████                    │ │
│  │                                    │                                  │ │
│  │  Price issue                 18%   │  System             7%           │ │
│  │  ██████████                        │  ████                            │ │
│  │                                    │                                  │ │
│  │  Service not needed          12%   │                                  │ │
│  │  ███████                           │                                  │ │
│  │                                    │                                  │ │
│  │  Other                        7%   │                                  │ │
│  │  ████                              │                                  │ │
│  └────────────────────────────────────┴──────────────────────────────────┘ │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Key Features

### 1. Booking Status KPIs
- **Total Bookings**: All bookings in period
- **Completed Bookings**: Successfully finished
- **Cancelled Bookings**: Cancelled by either party
- **Pending Bookings**: Awaiting acceptance/completion
- **Success Rate**: Completed / Total × 100%
- Trend indicators with % change

### 2. Booking Trend Chart
- Multi-line chart showing:
  - Total bookings (blue)
  - Completed (green)
  - Cancelled (red)
  - Pending (yellow)
- Time granularity based on date range
- Interactive tooltips
- Zoom and filter controls

### 3. Status Distribution
- Pie/Donut chart showing percentage of each status
- Color-coded segments
- Click to drill down

### 4. Peak Hours Analysis
- Bar chart showing bookings by hour
- Identifies busiest times
- Helps with provider allocation
- Separate view for weekday vs weekend

### 5. Top Services Table
- Ranked by booking count
- Shows:
  - Service name with icon
  - Total bookings
  - Completion rate %
  - Average rating
  - Trend (up/down/stable)
- Sortable columns
- Link to service details

### 6. Cancellation Analysis
- **Reasons Breakdown**: Why bookings cancelled
- **Cancelled By**: Who initiated cancellation
- Horizontal bar charts
- Actionable insights

### 7. Additional Metrics
- Average booking value
- Average service duration
- Repeat booking rate
- Customer acquisition source

## Component Breakdown

```typescript
// components/admin/BookingAnalytics.tsx
'use client'

import React, { useState, useEffect } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Button } from '@/components/ui/button'
import {
  LineChart, Line, BarChart, Bar, PieChart, Pie, Cell,
  XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer
} from 'recharts'
import { Download, TrendingUp, TrendingDown, Minus } from 'lucide-react'

interface BookingAnalyticsData {
  totalBookings: number
  completedBookings: number
  cancelledBookings: number
  pendingBookings: number
  successRate: number
  percentChange: {
    totalBookings: number
    completedBookings: number
    cancelledBookings: number
    pendingBookings: number
    successRate: number
  }
  trendData: Array<{
    date: string
    total: number
    completed: number
    cancelled: number
    pending: number
  }>
  statusDistribution: Array<{
    name: string
    value: number
    color: string
  }>
  peakHours: Array<{
    hour: string
    bookings: number
  }>
  topServices: Array<{
    name: string
    icon: string
    bookings: number
    completionRate: number
    avgRating: number
    trend: 'up' | 'down' | 'stable'
  }>
  cancellationReasons: Array<{
    reason: string
    percentage: number
  }>
  cancelledBy: Array<{
    party: string
    percentage: number
  }>
}

export default function BookingAnalytics() {
  const [dateRange, setDateRange] = useState('last_30_days')
  const [cityFilter, setCityFilter] = useState('all')
  const [statusFilter, setStatusFilter] = useState('all')
  const [data, setData] = useState<BookingAnalyticsData | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetchBookingData()
  }, [dateRange, cityFilter, statusFilter])

  const fetchBookingData = async () => {
    setLoading(true)
    try {
      const response = await fetch('/api/admin/analytics/bookings', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ dateRange, cityFilter, statusFilter })
      })
      const result = await response.json()
      setData(result.data)
    } catch (error) {
      console.error('Failed to fetch booking data:', error)
    } finally {
      setLoading(false)
    }
  }

  const exportData = async (format: 'csv' | 'excel' | 'pdf') => {
    try {
      const response = await fetch('/api/admin/analytics/bookings/export', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ dateRange, cityFilter, statusFilter, format })
      })
      const blob = await response.blob()
      const url = window.URL.createObjectURL(blob)
      const a = document.createElement('a')
      a.href = url
      a.download = `booking_report_${Date.now()}.${format}`
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
        <h1 className="text-3xl font-bold">📅 Booking Analytics</h1>
        <div className="flex gap-2">
          <Button onClick={() => exportData('csv')} variant="outline">
            <Download className="w-4 h-4 mr-2" />
            Export
          </Button>
        </div>
      </div>

      {/* Filters */}
      <div className="flex gap-4">
        <Select value={dateRange} onValueChange={setDateRange}>
          <SelectTrigger className="w-[200px]">
            <SelectValue />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="today">Today</SelectItem>
            <SelectItem value="last_7_days">Last 7 Days</SelectItem>
            <SelectItem value="last_30_days">Last 30 Days</SelectItem>
            <SelectItem value="this_month">This Month</SelectItem>
          </SelectContent>
        </Select>

        <Select value={cityFilter} onValueChange={setCityFilter}>
          <SelectTrigger className="w-[200px]">
            <SelectValue />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Cities</SelectItem>
            <SelectItem value="delhi">Delhi NCR</SelectItem>
            <SelectItem value="mumbai">Mumbai</SelectItem>
            <SelectItem value="bangalore">Bangalore</SelectItem>
          </SelectContent>
        </Select>

        <Select value={statusFilter} onValueChange={setStatusFilter}>
          <SelectTrigger className="w-[200px]">
            <SelectValue />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Status</SelectItem>
            <SelectItem value="completed">Completed</SelectItem>
            <SelectItem value="cancelled">Cancelled</SelectItem>
            <SelectItem value="pending">Pending</SelectItem>
          </SelectContent>
        </Select>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-5 gap-4">
        <KPICard
          title="Total Bookings"
          value={data.totalBookings.toString()}
          change={data.percentChange.totalBookings}
        />
        <KPICard
          title="Completed Bookings"
          value={data.completedBookings.toString()}
          change={data.percentChange.completedBookings}
        />
        <KPICard
          title="Cancelled Bookings"
          value={data.cancelledBookings.toString()}
          change={data.percentChange.cancelledBookings}
          inverse
        />
        <KPICard
          title="Pending Bookings"
          value={data.pendingBookings.toString()}
          change={data.percentChange.pendingBookings}
          inverse
        />
        <KPICard
          title="Success Rate"
          value={`${data.successRate.toFixed(1)}%`}
          change={data.percentChange.successRate}
        />
      </div>

      {/* Booking Trend */}
      <Card>
        <CardHeader>
          <CardTitle>Booking Trend</CardTitle>
        </CardHeader>
        <CardContent>
          <ResponsiveContainer width="100%" height={300}>
            <LineChart data={data.trendData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="date" />
              <YAxis />
              <Tooltip />
              <Legend />
              <Line type="monotone" dataKey="total" stroke="#3B82F6" strokeWidth={2} name="Total" />
              <Line type="monotone" dataKey="completed" stroke="#10B981" strokeWidth={2} name="Completed" />
              <Line type="monotone" dataKey="cancelled" stroke="#EF4444" strokeWidth={2} name="Cancelled" />
              <Line type="monotone" dataKey="pending" stroke="#F59E0B" strokeWidth={2} name="Pending" />
            </LineChart>
          </ResponsiveContainer>
        </CardContent>
      </Card>

      {/* Status Distribution & Peak Hours */}
      <div className="grid grid-cols-2 gap-4">
        <Card>
          <CardHeader>
            <CardTitle>Booking Status Distribution</CardTitle>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={250}>
              <PieChart>
                <Pie
                  data={data.statusDistribution}
                  cx="50%"
                  cy="50%"
                  labelLine={false}
                  label={({ name, percent }) => `${name} ${(percent * 100).toFixed(0)}%`}
                  outerRadius={80}
                  fill="#8884d8"
                  dataKey="value"
                >
                  {data.statusDistribution.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Peak Hours</CardTitle>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={250}>
              <BarChart data={data.peakHours}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="hour" />
                <YAxis />
                <Tooltip />
                <Bar dataKey="bookings" fill="#0D7377" />
              </BarChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      </div>

      {/* Top Services Table */}
      <Card>
        <CardHeader>
          <CardTitle>Top Services by Bookings</CardTitle>
        </CardHeader>
        <CardContent>
          <table className="w-full">
            <thead>
              <tr className="border-b">
                <th className="text-left p-2">Service</th>
                <th className="text-right p-2">Bookings</th>
                <th className="text-right p-2">Completion Rate</th>
                <th className="text-right p-2">Avg Rating</th>
                <th className="text-center p-2">Trend</th>
              </tr>
            </thead>
            <tbody>
              {data.topServices.map((service, index) => (
                <tr key={index} className="border-b hover:bg-gray-50">
                  <td className="p-2">
                    <span className="mr-2">{service.icon}</span>
                    {service.name}
                  </td>
                  <td className="text-right p-2">{service.bookings}</td>
                  <td className="text-right p-2">{service.completionRate}%</td>
                  <td className="text-right p-2">{service.avgRating} ⭐</td>
                  <td className="text-center p-2">
                    {service.trend === 'up' && <TrendingUp className="inline w-4 h-4 text-green-600" />}
                    {service.trend === 'down' && <TrendingDown className="inline w-4 h-4 text-red-600" />}
                    {service.trend === 'stable' && <Minus className="inline w-4 h-4 text-gray-600" />}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </CardContent>
      </Card>

      {/* Cancellation Analysis */}
      <div className="grid grid-cols-2 gap-4">
        <Card>
          <CardHeader>
            <CardTitle>Cancellation Reasons</CardTitle>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={250}>
              <BarChart data={data.cancellationReasons} layout="vertical">
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis type="number" />
                <YAxis dataKey="reason" type="category" width={150} />
                <Tooltip />
                <Bar dataKey="percentage" fill="#EF4444" />
              </BarChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Cancelled By</CardTitle>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={250}>
              <BarChart data={data.cancelledBy} layout="vertical">
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis type="number" />
                <YAxis dataKey="party" type="category" />
                <Tooltip />
                <Bar dataKey="percentage" fill="#FF6B35" />
              </BarChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}

function KPICard({ title, value, change, inverse = false }: {
  title: string
  value: string
  change: number
  inverse?: boolean
}) {
  const isPositive = inverse ? change < 0 : change >= 0

  return (
    <Card>
      <CardHeader className="pb-2">
        <CardTitle className="text-sm font-medium text-gray-600">{title}</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="text-2xl font-bold">{value}</div>
        <div className={`flex items-center text-sm ${isPositive ? 'text-green-600' : 'text-red-600'}`}>
          {isPositive ? <TrendingUp className="w-4 h-4 mr-1" /> : <TrendingDown className="w-4 h-4 mr-1" />}
          {Math.abs(change)}%
        </div>
      </CardContent>
    </Card>
  )
}
```

## API Integration

### Get Booking Analytics
```
POST /api/admin/analytics/bookings

Request:
{
  "dateRange": "last_30_days",
  "cityFilter": "all",
  "statusFilter": "all"
}

Response:
{
  "success": true,
  "data": {
    "totalBookings": 4582,
    "completedBookings": 3845,
    "cancelledBookings": 458,
    "pendingBookings": 279,
    "successRate": 83.9,
    "percentChange": {
      "totalBookings": 12.5,
      "completedBookings": 15.2,
      "cancelledBookings": -5.3,
      "pendingBookings": -8.1,
      "successRate": 2.3
    },
    "trendData": [...],
    "statusDistribution": [...],
    "peakHours": [...],
    "topServices": [...],
    "cancellationReasons": [...],
    "cancelledBy": [...]
  }
}
```

## Testing Checklist

- [ ] All filters update data correctly
- [ ] KPI cards show accurate numbers
- [ ] Trend chart displays all series
- [ ] Status pie chart renders correctly
- [ ] Peak hours bar chart shows hourly data
- [ ] Top services table sorts correctly
- [ ] Cancellation charts display reasons
- [ ] Export functionality works
- [ ] Responsive design works

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platform**: Web (Next.js)
