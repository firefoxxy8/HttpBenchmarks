﻿using System;
using Funq;
using ServiceStack;
using ServiceStack.Text;
using Techempower.ServiceInterface;

namespace Techempower.HttpListener.Pool
{
    public class AppHost : AppHostHttpListenerPoolBase
    {
        private readonly DbProvider db;

        public AppHost(int poolSize, DbProvider db)
            : base("HttpListener Pool Techempower Benchmarks", poolSize, typeof (TechmeServices).Assembly)
        {
            this.db = db;
        }

        public override void Configure(Container container)
        {
            ConfigApp.AppHost(this, db);
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            int poolSize;
            if (!(args.Length > 0 && int.TryParse(args[0], out poolSize)))
                poolSize = AppHostHttpListenerBase.CalculatePoolSize();

            DbProvider db;
            if (!(args.Length > 1 && Enum.TryParse(args[1], true, out db)))
                db = DbProvider.InMemory;

            new AppHost(poolSize, db)
                .Init()
                .Start("http://*:55002/");

            "\nHttpListener Pool started with ThreadPool size of {0} using {1} listening on tcp port 55002"
                .Print(poolSize, db);
            "Press Enter to Quit".Print();
            Console.ReadLine();
        }
    }
}
