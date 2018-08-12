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
        string IdSucursal { get; set; }
        string IdEntidad { get; set; }
        string em_direccion { get; set; }
        string IdTransaccionSession { get; set; }
        string IdTransaccionSessionActual { get; set; }
        string IdEmpresaActual { get; set; }

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
        public static string IdEmpresaActual
        {
            get { return _sessionValueProvider.IdEmpresaActual; }
            set { _sessionValueProvider.IdEmpresaActual = value; }
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
        public static string IdSucursal
        {
            get { return _sessionValueProvider.IdSucursal; }
            set { _sessionValueProvider.IdSucursal = value; }
        }
        public static string IdEntidad
        {
            get { return _sessionValueProvider.IdEntidad; }
            set { _sessionValueProvider.IdEntidad = value; }
        }
        public static string em_direccion
        {
            get { return _sessionValueProvider.em_direccion; }
            set { _sessionValueProvider.em_direccion = value; }
        }
        public static string IdTransaccionSession
        {
            get { return _sessionValueProvider.IdTransaccionSession; }
            set { _sessionValueProvider.IdTransaccionSession = value; }
        }
        public static string IdTransaccionSessionActual
        {
            get { return _sessionValueProvider.IdTransaccionSessionActual; }
            set { _sessionValueProvider.IdTransaccionSessionActual = value; }
        }
    }

    public class WebSessionValueProvider : ISessionValueProvider
    {
        private const string _IdTipoPersona = "PERSONA";
        private const string _IdUsuario = "IdUsuario";
        private const string _IdEmpresa = "IdEmpresa";
        private const string _NomEmpresa = "FIXED";
        private const string _IdProducto_padre_dist = "IdProducto_padre_dist";
        private const string _IdEntidad = "IdEntidadParam";
        private const string _IdSucursal = "IdSucursal";
        private const string _em_direccion = "em_direccion";
        private const string _IdTransaccionSession = "IdTransaccionSesssion";
        private const string _IdTransaccionSessionActual = "IdTransaccionSessionActual";
        private const string _IdEmpresaActual = "IdEmpresaActual";
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
        public string IdEmpresaActual
        {
            get { return (string)HttpContext.Current.Session[_IdEmpresaActual]; }
            set { HttpContext.Current.Session[_IdEmpresaActual] = value; }
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
        public string IdSucursal
        {
            get { return (string)HttpContext.Current.Session[_IdSucursal]; }
            set { HttpContext.Current.Session[_IdSucursal] = value; }
        }
        public string IdEntidad
        {
            get { return (string)HttpContext.Current.Session[_IdEntidad]; }
            set { HttpContext.Current.Session[_IdEntidad] = value; }
        }
        public string em_direccion
        {
            get { return (string)HttpContext.Current.Session[_em_direccion]; }
            set { HttpContext.Current.Session[_em_direccion] = value; }
        }
        public string IdTransaccionSession
        {
            get { return (string)HttpContext.Current.Session[_IdTransaccionSession]; }
            set { HttpContext.Current.Session[_IdTransaccionSession] = value; }
        }
        public string IdTransaccionSessionActual
        {
            get { return (string)HttpContext.Current.Session[_IdTransaccionSessionActual]; }
            set { HttpContext.Current.Session[_IdTransaccionSessionActual] = value; }
        }
    }
}