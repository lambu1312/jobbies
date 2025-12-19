<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map.Entry" %>
<%@page import="model.JobPostings" %>
<%@page import="model.Account" %>
<%@page import="model.Recruiters" %>
<%@page import="dao.RecruitersDAO" %>
<%@page import="dao.AccountDAO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Admin - Home</title>
        <!--css-->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* Common styling for all dashboard cards */
            .dashboard-card {
                padding: 20px;
                border-radius: 6px;
                box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
                color: white;
            }

            .dashboard-card h3 {
                font-size: 1.25rem;
                margin-bottom: 5px;
            }

            .dashboard-card p {
                font-size: 1rem;
                margin: 0;
            }

            .dashboard-card i {
                font-size: 1.5rem;
                margin-bottom: 5px;
            }

            /* Unique colors for each type of card */
            .bg-seekers {
                background-color: #007bff;
            }

            .bg-recruiters {
                background-color: #ffc107;
            }

            .bg-companies {
                background-color: #17a2b8;
            }

            /* CSS cho tiêu đề biểu đồ */
            .chart-title-purple {
                background-color: #a855f7;
                color: #fff;
                padding: 15px;
                text-align: center;
                font-size: 1.5rem;
                font-weight: bold;
                margin: 0;
                border-radius: 5px 5px 0 0;
            }

            .chart-title-green {
                background-color: #10b981;
                color: #fff;
                padding: 15px;
                text-align: center;
                font-size: 1.5rem;
                font-weight: bold;
                margin: 0;
                border-radius: 5px 5px 0 0;
            }

            .chart-container {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-top: 0;
            }

            .chart-container .card-body {
                padding: 20px;
            }

            /* Styling cho bộ lọc */
            .filter-container {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .filter-container h5 {
                margin-bottom: 15px;
                color: #333;
                font-weight: 600;
            }

            .date-input-group {
                display: flex;
                gap: 10px;
                align-items: end;
            }

            .date-input-group .form-group {
                flex: 1;
            }

            .date-input-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: 500;
                color: #555;
            }

            .date-input-group input[type="date"] {
                width: 100%;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }

            .btn-filter {
                padding: 8px 24px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.3s;
            }

            .btn-filter:hover {
                background-color: #0056b3;
            }

            .btn-reset {
                padding: 8px 24px;
                background-color: #6c757d;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.3s;
            }

            .btn-reset:hover {
                background-color: #545b62;
            }
        </style>
    </head>

    <body>
        <div class="row g-0">
            <div class="col-md-2">
                <!--Side bar-->
                <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
                <!--side bar-end-->
            </div>

            <div class="col-md-10 ps-0">
                <div class="dashboard__right">
                    <div class="dash__content">
                        <!-- Bộ lọc theo ngày -->
                        <div class="container-fluid py-4">
                            <div class="filter-container">
                                <h5><i class="fas fa-filter me-2"></i>Bộ lọc theo ngày</h5>
                                <form action="dashboard" method="GET">
                                    <div class="date-input-group">
                                        <div class="form-group">
                                            <label for="startDate">Từ ngày:</label>
                                            <input type="date" id="startDate" name="startDate" 
                                                   class="form-control" value="${param.startDate}">
                                        </div>
                                        <div class="form-group">
                                            <label for="endDate">Đến ngày:</label>
                                            <input type="date" id="endDate" name="endDate" 
                                                   class="form-control" value="${param.endDate}">
                                        </div>
                                        <div>
                                            <button type="submit" class="btn-filter">
                                                <i class="fas fa-search me-1"></i>Lọc
                                            </button>
                                        </div>
                                        <div>
                                            <button type="button" class="btn-reset" onclick="resetFilter()">
                                                <i class="fas fa-redo me-1"></i>Đặt lại
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="dash__overview">
                            <!-- Dashboard Stats Overview -->
                            <div class="container-fluid py-4">
                                <div class="row">
                                    <!-- Total Seekers -->
                                    <div class="col-md-6 mb-4">
                                        <div class="dashboard-card bg-seekers">
                                            <i class="fas fa-user fa-2x text-white mb-2"></i>
                                            <h3>Total Seekers</h3>
                                            <p id="total-seekers">${totalSeeker}</p>
                                            <p class="text-white">Active: <span id="active-seekers">${totalSeekerActive}</span></p>
                                            <p class="text-white">Inactive: <span id="inactive-seekers">${totalSeekerInactive}</span></p>
                                        </div>
                                    </div>

                                    <!-- Total Recruiters -->
                                    <div class="col-md-6 mb-4">
                                        <div class="dashboard-card bg-recruiters">
                                            <i class="fas fa-user-tie fa-2x text-white mb-2"></i>
                                            <h3>Total Recruiters</h3>
                                            <p id="total-recruiters">${totalRecruiter}</p>
                                            <p class="text-white">Active: <span id="active-recruiters">${totalRecruiterActive}</span></p>
                                            <p class="text-white">Inactive: <span id="inactive-recruiters">${totalRecruiterInactive}</span></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Chart Section -->
                    <div class="container-fluid py-10">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="card chart-container">
                                    <h4 class="chart-title-purple">Top 5 Employers with the Most Posts Chart</h4>
                                    <div class="card-body">
                                        <canvas id="jobPostingTopRecruitersChart"></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card chart-container">
                                    <h4 class="chart-title-green">Job Posting Status Chart</h4>
                                    <div class="card-body">
                                        <canvas id="jobPostingStatusChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- all plugin js -->
        <jsp:include page="../common/admin/common-js-admin.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
        
        <script>
            // Hàm reset bộ lọc
            function resetFilter() {
                document.getElementById('startDate').value = '';
                document.getElementById('endDate').value = '';
                window.location.href = 'dashboard';
            }

            // Khởi tạo dữ liệu top 5 recruiter
            const topRecruitersData = {
            <%
                Map< Integer, Integer> recruiterPostCount = (Map< Integer, Integer>) request.getAttribute("recruiterPostCount");
                Recruiters recruiter = new Recruiters();
                RecruitersDAO recruiterDao = new RecruitersDAO();
                Account account = new Account();
                AccountDAO accDao = new AccountDAO();
                if (recruiterPostCount != null) {
                    int count = 0;
                    for (Map.Entry< Integer, Integer> entry : recruiterPostCount.entrySet()) {
                        int recruiterId = entry.getKey();
                        recruiter = recruiterDao.findById(String.valueOf(recruiterId));
                        account = accDao.findUserById(recruiter.getAccountID());
                        int postCount = entry.getValue();
                        out.print("\"" + account.getFullName() + "\": " + postCount);
                        if (count < recruiterPostCount.size() - 1) {
                            out.print(", ");
                        }
                        count++;
                    }
                }
            %>
            };

            const labelsTopRecruiters = Object.keys(topRecruitersData);
            const dataTopRecruiters = Object.values(topRecruitersData);

            // Biểu đồ Top 5 Recruiters
            const ctxTopRecruiters = document.getElementById('jobPostingTopRecruitersChart').getContext('2d');
            new Chart(ctxTopRecruiters, {
                type: 'bar',
                data: {
                    labels: labelsTopRecruiters,
                    datasets: [{
                        label: 'Number of job postings',
                        data: dataTopRecruiters,
                        backgroundColor: 'rgba(153, 102, 255, 0.5)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1,
                        barThickness: 30,
                        maxBarThickness: 50
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Number of job postings'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Recruiter'
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            position: 'top'
                        },
                        title: {
                            display: true,
                            text: 'Top 5 Employers with the Most Posts'
                        }
                    }
                }
            });

            // Biểu đồ Job Posting Status
            const jobPostingStatusData = {
            <%
                Map< String, Integer> jobPostingStatusData = (Map< String, Integer>) request.getAttribute("jobPostingStatusData");
                if (jobPostingStatusData != null) {
                    int count = 0;
                    for (Map.Entry< String, Integer> entry : jobPostingStatusData.entrySet()) {
                        String status = entry.getKey();
                        int value = entry.getValue();
                        out.print("\"" + status + "\": " + value);
                        if (count < jobPostingStatusData.size() - 1) {
                            out.print(", ");
                        }
                        count++;
                    }
                }
            %>
            };

            const ctxJobPostingStatus = document.getElementById('jobPostingStatusChart').getContext('2d');
            new Chart(ctxJobPostingStatus, {
                type: 'pie',
                data: {
                    labels: Object.keys(jobPostingStatusData),
                    datasets: [{
                        data: Object.values(jobPostingStatusData),
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.5)',
                            'rgba(255, 206, 86, 0.5)',
                            'rgba(75, 192, 192, 0.5)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top'
                        },
                        title: {
                            display: true,
                            text: 'Job Posting Status'
                        },
                        datalabels: {
                            color: '#fff',
                            formatter: (value, ctx) => {
                                let sum = ctx.dataset.data.reduce((a, b) => a + b, 0);
                                let percentage = (value * 100 / sum).toFixed(2) + "%";
                                return percentage;
                            },
                            font: {
                                weight: 'bold'
                            }
                        }
                    }
                },
                plugins: [ChartDataLabels]
            });
        </script>

        <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
            integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
            crossorigin="anonymous"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
            integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
            crossorigin="anonymous"></script>
    </body>
</html>