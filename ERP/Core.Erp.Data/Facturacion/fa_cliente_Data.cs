using Core.Erp.Data.General;
using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Facturacion
{
    public class fa_cliente_Data
    {
        public List<fa_cliente_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<fa_cliente_Info> Lista;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.vwfa_cliente_consulta
                                 join t in Context.fa_cliente_tipo
                                 on new { q.IdEmpresa, q.Idtipo_cliente} equals new { t.IdEmpresa, t.Idtipo_cliente}
                                 where q.IdEmpresa == IdEmpresa
                                 select new fa_cliente_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     Codigo = q.Codigo,
                                     Estado = q.Estado,
                                     IdCliente = q.IdCliente,
                                     Descripcion_tip_cliente = t.Descripcion_tip_cliente,
                                     info_persona = new Info.General.tb_persona_Info
                                     {
                                         IdPersona = q.IdPersona,
                                         pe_nombreCompleto = q.pe_nombreCompleto,
                                         pe_cedulaRuc = q.pe_cedulaRuc
                                     }
                                 }).ToList();
                    else

                        Lista = (from q in Context.vwfa_cliente_consulta
                                 join t in Context.fa_cliente_tipo
                                 on new { q.IdEmpresa, q.Idtipo_cliente } equals new { t.IdEmpresa, t.Idtipo_cliente }
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 select new fa_cliente_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     Codigo = q.Codigo,
                                     Estado = q.Estado,
                                     IdCliente = q.IdCliente,
                                     Descripcion_tip_cliente = t.Descripcion_tip_cliente,
                                     info_persona = new Info.General.tb_persona_Info
                                     {
                                         IdPersona = q.IdPersona,
                                         pe_nombreCompleto = q.pe_nombreCompleto,
                                         pe_cedulaRuc = q.pe_cedulaRuc
                                     }
                                 }).ToList();

                }
                
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public fa_cliente_Info get_info(int IdEmpresa, decimal IdCliente)
        {
            try
            {
                fa_cliente_Info info = new fa_cliente_Info();
                Entities_facturacion Context_f = new Entities_facturacion();
                Entities_general Context_g = new Entities_general();

                fa_cliente Entity = Context_f.fa_cliente.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdCliente == IdCliente);
                if (Entity == null) return null;

                info = new fa_cliente_Info
                {
                    IdEmpresa = Entity.IdEmpresa,
                    cl_Cupo = Entity.cl_Cupo,
                    cl_plazo = Entity.cl_plazo,
                    Codigo = Entity.Codigo,
                    Estado = Entity.Estado,
                    es_empresa_relacionada = Entity.es_empresa_relacionada == null ? false : Convert.ToBoolean(Entity.es_empresa_relacionada),
                    IdCliente = Entity.IdCliente,
                    FormaPago = Entity.FormaPago,
                    IdCtaCble_Anti = Entity.IdCtaCble_Anti,
                    IdCtaCble_cxc = Entity.IdCtaCble_cxc,
                    IdCtaCble_cxc_Credito = Entity.IdCtaCble_cxc_Credito,
                    IdPersona = Entity.IdPersona,
                    IdTipoCredito = Entity.IdTipoCredito,
                    Idtipo_cliente = Entity.Idtipo_cliente,
                    NivelPrecio = Entity.NivelPrecio
                };
                tb_persona Entity_p = Context_g.tb_persona.Where(q => q.IdPersona == info.IdPersona).FirstOrDefault();
                info.info_persona = new Info.General.tb_persona_Info
                {
                    IdPersona = Entity_p.IdPersona,
                    pe_apellido = Entity_p.pe_apellido,
                    pe_nombre = Entity_p.pe_nombre,
                    pe_cedulaRuc = Entity_p.pe_cedulaRuc,
                    pe_nombreCompleto = Entity_p.pe_nombreCompleto,
                    pe_razonSocial = Entity_p.pe_razonSocial,
                    pe_Naturaleza = Entity_p.pe_Naturaleza,
                    IdTipoDocumento = Entity_p.IdTipoDocumento
                };

                Context_f.Dispose();
                Context_g.Dispose();
                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public fa_cliente_Info get_info_x_num_cedula(int IdEmpresa, string pe_cedulaRuc)
        {
            try
            {
                fa_cliente_Info info = new fa_cliente_Info
                {
                    info_persona = new Info.General.tb_persona_Info()
                };

                Entities_general Context_general = new Entities_general();
                tb_persona Entity_p = Context_general.tb_persona.Where(q => q.pe_cedulaRuc == pe_cedulaRuc).FirstOrDefault();
                if (Entity_p == null)
                {
                    Context_general.Dispose();
                    return info;
                }

                Entities_facturacion Context_facturacion = new Entities_facturacion();
                fa_cliente Entity_c = Context_facturacion.fa_cliente.Where(q => q.IdEmpresa == IdEmpresa && q.IdPersona == Entity_p.IdPersona).FirstOrDefault();
                if (Entity_c == null)
                {
                    info.IdPersona = Entity_p.IdPersona;
                    info.info_persona = new Info.General.tb_persona_Info
                    {
                        IdPersona = Entity_p.IdPersona,
                        pe_apellido = Entity_p.pe_apellido,
                        pe_nombre = Entity_p.pe_nombre,
                        pe_cedulaRuc = Entity_p.pe_cedulaRuc,
                        pe_nombreCompleto = Entity_p.pe_nombreCompleto,
                        pe_razonSocial = Entity_p.pe_razonSocial,
                        pe_celular = Entity_p.pe_celular,
                        pe_telfono_Contacto = Entity_p.pe_telfono_Contacto,
                        pe_correo = Entity_p.pe_correo,
                        pe_direccion = Entity_p.pe_direccion
                    };
                    Context_general.Dispose();
                    Context_facturacion.Dispose();
                    return info;
                }

                info = new fa_cliente_Info
                {
                    IdEmpresa = Entity_c.IdEmpresa,
                    IdCliente = Entity_c.IdCliente,
                    IdPersona = Entity_p.IdPersona,
                    info_persona = new Info.General.tb_persona_Info
                    {
                        IdPersona = Entity_p.IdPersona,
                        pe_apellido = Entity_p.pe_apellido,
                        pe_nombre = Entity_p.pe_nombre,
                        pe_cedulaRuc = Entity_p.pe_cedulaRuc,
                        pe_nombreCompleto = Entity_p.pe_nombreCompleto,
                        pe_razonSocial = Entity_p.pe_razonSocial,
                        pe_celular = Entity_p.pe_celular,
                        pe_telfono_Contacto = Entity_p.pe_telfono_Contacto,
                        pe_correo = Entity_p.pe_correo,
                        pe_direccion = Entity_p.pe_direccion
                    }
            };

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        private decimal get_id(int IdEmpresa)
        {
            try
            {
                decimal ID = 1;

                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    var lst = from q in Context.fa_cliente
                              where q.IdEmpresa == IdEmpresa
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdCliente)+1;
                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(fa_cliente_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_cliente Entity = new fa_cliente
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdCliente = info.IdCliente = get_id(info.IdEmpresa),
                        cl_Cupo = info.cl_Cupo,
                        cl_plazo = info.cl_plazo,
                        Codigo = info.Codigo,
                        Estado = info.Estado = "A",
                        es_empresa_relacionada = info.es_empresa_relacionada,
                        FormaPago = info.FormaPago,
                        IdCtaCble_Anti = info.IdCtaCble_Anti,
                        IdCtaCble_cxc = info.IdCtaCble_cxc,
                        IdCtaCble_cxc_Credito = info.IdCtaCble_cxc_Credito,
                        IdPersona = info.IdPersona,
                        IdTipoCredito = info.IdTipoCredito,
                        Idtipo_cliente = info.Idtipo_cliente,
                        NivelPrecio = info.NivelPrecio,

                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                    };
                    Context.fa_cliente.Add(Entity);
                    foreach (var item in info.lst_fa_cliente_contactos)
                    {
                        fa_cliente_contactos Entity_det = new fa_cliente_contactos
                        {
                            IdEmpresa = Entity.IdEmpresa,
                            IdCliente = Entity.IdCliente,
                            IdContacto = item.IdContacto,
                            IdCiudad = item.IdCiudad,
                            IdParroquia = item.IdParroquia,
                            Celular = item.Celular,
                            Correo = item.Correo,
                            Direccion = item.Direccion,
                            Nombres = item.Nombres,
                            Telefono = item.Telefono
                        };
                        Context.fa_cliente_contactos.Add(Entity_det);
                    }
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(fa_cliente_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_cliente Entity = Context.fa_cliente.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdCliente == info.IdCliente);
                    if (Entity == null) return false;

                    Entity.cl_Cupo = info.cl_Cupo;
                    Entity.cl_plazo = info.cl_plazo;
                    Entity.Codigo = info.Codigo;
                    Entity.es_empresa_relacionada = info.es_empresa_relacionada;
                    Entity.FormaPago = info.FormaPago;
                    Entity.IdCtaCble_Anti = info.IdCtaCble_Anti;
                    Entity.IdCtaCble_cxc = info.IdCtaCble_cxc;
                    Entity.IdCtaCble_cxc_Credito = info.IdCtaCble_cxc_Credito;
                    Entity.IdTipoCredito = info.IdTipoCredito;
                    Entity.Idtipo_cliente = info.Idtipo_cliente;
                    Entity.NivelPrecio = info.NivelPrecio;

                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(fa_cliente_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_cliente Entity = Context.fa_cliente.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdCliente == info.IdCliente);
                    if (Entity == null) return false;

                    Entity.Estado = info.Estado = "I";

                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = DateTime.Now;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
