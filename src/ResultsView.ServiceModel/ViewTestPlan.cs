﻿using System.Collections.Generic;
using ResultsView.ServiceModel.Types;
using ServiceStack;
using ServiceStack.Text;

namespace ResultsView.ServiceModel
{
    [FallbackRoute("/{Slug}")]
    public class ViewTestPlan : IReturn<ViewTestPlanResponse>
    {
        public string Slug { get; set; }
        public int? Id { get; set; }
    }

    [Csv(CsvBehavior.FirstEnumerable)]
    public class ViewTestPlanResponse
    {
        public TestPlan TestPlan { get; set; }

        public TestRun TestRun { get; set; }

        public List<DisplayResult> Results { get; set; }

        public ResponseStatus ResponseStatus { get; set; }
    }
}