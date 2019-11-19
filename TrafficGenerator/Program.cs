using System;
using System.Net.Http;
using System.Threading;

namespace TrafficGenerator
{
    class Program
    {
        static void Main(string[] args)
        {
            var httpClient = new HttpClient();


            for (var i = 0; i < 10_000; i++)
            {
                using (var request = new HttpRequestMessage(HttpMethod.Get, "http://40.80.157.109/productpage"))
                {
                    request.Headers.Add("ClientId", "BCBSSC");
                    var response = httpClient.SendAsync(request).GetAwaiter().GetResult();

                    Console.Write(response.Headers.ToString());
                    Console.WriteLine(response.Content.Headers.ToString());
                }
                
                Thread.Sleep(250);
            }
        }
    }
}
