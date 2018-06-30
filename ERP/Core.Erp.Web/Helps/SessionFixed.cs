using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Core.Erp.Web.Helps
{
    public interface ISessionValueProvider
    {
        string CurrentTipoPersona { get; set; }
        string IdEmpresa { get; set; }
    }

    public static class SessionFixed
    {
        private static ISessionValueProvider _sessionValueProvider;
        public static void SetSessionValueProvider(ISessionValueProvider provider)
        {
            _sessionValueProvider = provider;
        }

        public static string CurrentTipoPersona
        {
            get { return _sessionValueProvider.CurrentTipoPersona; }
            set { _sessionValueProvider.CurrentTipoPersona = value; }
        }

        public static string IdEmpresa
        {
            get { return _sessionValueProvider.IdEmpresa; }
            set { _sessionValueProvider.IdEmpresa = value; }
        }
    }

    public class WebSessionValueProvider : ISessionValueProvider
    {
        private const string TIPOPERSONA = "PERSONA";
        private const string IDEMPRESA = "0";
        public string CurrentTipoPersona
        {
            get { return (string)HttpContext.Current.Session[TIPOPERSONA]; }
            set { HttpContext.Current.Session[TIPOPERSONA] = value; }
        }

        public string IdEmpresa
        {
            get { return (string)HttpContext.Current.Session[IDEMPRESA]; }
            set { HttpContext.Current.Session[IDEMPRESA] = value; }
        }
    }
}