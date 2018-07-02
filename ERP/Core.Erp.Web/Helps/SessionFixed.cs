using System.Web;

namespace Core.Erp.Web.Helps
{
    public interface ISessionValueProvider
    {
        string TipoPersona { get; set; }
        string IdEmpresa { get; set; }
        string IdUsuario { get; set; }
        string NomEmpresa { get; set; }
        string IdProducto_padre_dist { get; set; }
    }

    public static class SessionFixed
    {
        private static ISessionValueProvider _sessionValueProvider;
        public static void SetSessionValueProvider(ISessionValueProvider provider)
        {
            _sessionValueProvider = provider;
        }

        public static string TipoPersona
        {
            get { return _sessionValueProvider.TipoPersona; }
            set { _sessionValueProvider.TipoPersona = value; }
        }

        public static string IdEmpresa
        {
            get { return _sessionValueProvider.IdEmpresa; }
            set { _sessionValueProvider.IdEmpresa = value; }
        }
        public static string NomEmpresa
        {
            get { return _sessionValueProvider.NomEmpresa; }
            set { _sessionValueProvider.NomEmpresa = value; }
        }
        public static string IdUsuario
        {
            get { return _sessionValueProvider.IdUsuario; }
            set { _sessionValueProvider.IdUsuario = value; }
        }
        public static string IdProducto_padre_dist
        {
            get { return _sessionValueProvider.IdProducto_padre_dist; }
            set { _sessionValueProvider.IdProducto_padre_dist = value; }
        }
    }

    public class WebSessionValueProvider : ISessionValueProvider
    {
        private const string _IdTipoPersona = "PERSONA";
        private const string _IdUsuario = "IdUsuario";
        private const string _IdEmpresa = "IdEmpresa";
        private const string _NomEmpresa = "FIXED";
        private const string _IdProducto_padre_dist = "IdProducto_padre_dist";

        
        public string TipoPersona
        {
            get { return (string)HttpContext.Current.Session[_IdTipoPersona]; }
            set { HttpContext.Current.Session[_IdTipoPersona] = value; }
        }

        public string IdEmpresa
        {
            get { return (string)HttpContext.Current.Session[_IdEmpresa]; }
            set { HttpContext.Current.Session[_IdEmpresa] = value; }
        }
        public string IdUsuario
        {
            get { return (string)HttpContext.Current.Session[_IdUsuario]; }
            set { HttpContext.Current.Session[_IdUsuario] = value; }
        }
        public string NomEmpresa
        {
            get { return (string)HttpContext.Current.Session[_NomEmpresa]; }
            set { HttpContext.Current.Session[_NomEmpresa] = value; }
        }
        public string IdProducto_padre_dist
        {
            get { return (string)HttpContext.Current.Session[_IdProducto_padre_dist]; }
            set { HttpContext.Current.Session[_IdProducto_padre_dist] = value; }
        }
    }
}