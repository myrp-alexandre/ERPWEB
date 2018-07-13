using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Facturacion
{
  public  class fa_proforma_Data
    {
         public List<fa_proforma_Info> get_list(int IdEmpresa)
        {
            try
            {
                List<fa_proforma_Info> Lista;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    Lista = (from q in Context.fa_proforma
                             where q.IdEmpresa == IdEmpresa
                             select new fa_proforma_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdProforma = q.IdProforma,
                                 IdCliente = q.IdCliente,
                                 IdTerminoPago = q.IdTerminoPago,
                                 pf_plazo = q.pf_plazo,
                                 pf_codigo = q.pf_codigo,
                                 pf_observacion = q.pf_observacion,
                                 pf_fecha = q.pf_fecha,
                                 pf_fecha_vcto = q.pf_fecha_vcto,
                                 pf_atencion_a = q.pf_atencion_a,
                                 estado = q.estado,
                                 IdBodega = q.IdBodega,
                                 IdVendedor = q.IdVendedor,
                                 pr_dias_entrega = q.pr_dias_entrega
                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public fa_proforma_Info get_info(int IdEmpresa, int IdSucursal, decimal IdProforma)
        {
            try
            {
                fa_proforma_Info info = new fa_proforma_Info();
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_proforma Entity = Context.fa_proforma.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.IdProforma == IdProforma);
                    if (Entity == null) return null;
                    info = new fa_proforma_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdSucursal = Entity.IdSucursal,
                        IdProforma = Entity.IdProforma,
                        IdCliente = Entity.IdCliente,
                        IdTerminoPago = Entity.IdTerminoPago,
                        pf_plazo = Entity.pf_plazo,
                        pf_codigo = Entity.pf_codigo,
                        pf_observacion = Entity.pf_observacion,
                        pf_fecha = Entity.pf_fecha,
                        pf_fecha_vcto = Entity.pf_fecha_vcto,
                        pf_atencion_a = Entity.pf_atencion_a,
                        estado = Entity.estado,
                        IdBodega = Entity.IdBodega,
                        IdVendedor = Entity.IdVendedor,
                        pr_dias_entrega = Entity.pr_dias_entrega
                    };

                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public decimal get_id(int IdEmpresa, int IdSucursal)
        {

            try
            {
                decimal ID = 1;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    var lst = from q in Context.fa_proforma
                              where q.IdEmpresa == IdEmpresa
                              && q.IdSucursal == IdSucursal
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdProforma) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(fa_proforma_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_proforma Entity = new fa_proforma
                    {

                        IdEmpresa = info.IdEmpresa,
                        IdSucursal = info.IdSucursal,
                        IdProforma = info.IdProforma=get_id(info.IdEmpresa, info.IdSucursal),
                        IdCliente = info.IdCliente,
                        IdTerminoPago = info.IdTerminoPago,
                        pf_plazo = info.pf_plazo,
                        pf_codigo = info.pf_codigo,
                        pf_observacion = info.pf_observacion,
                        pf_fecha = info.pf_fecha,
                        pf_fecha_vcto = info.pf_fecha_vcto,
                        pf_atencion_a = info.pf_atencion_a,
                        estado = info.estado=true,
                        IdBodega = info.IdBodega,
                        IdVendedor = info.IdVendedor,
                        pr_dias_entrega = info.pr_dias_entrega,

                        IdUsuario_creacion = info.IdUsuario_creacion,
                        fecha_creacion = DateTime.Now
                    };
                    Context.fa_proforma.Add(Entity);
                    Context.SaveChanges();
                }
                return false;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(fa_proforma_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_proforma Entity = Context.fa_proforma.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal && q.IdProforma == info.IdProforma);
                    if (Entity == null) return false;

                    Entity.IdCliente = info.IdCliente;
                    Entity.IdTerminoPago = info.IdTerminoPago;
                    Entity.pf_plazo = info.pf_plazo;
                    Entity.pf_codigo = info.pf_codigo;
                    Entity.pf_observacion = info.pf_observacion;
                    Entity.pf_fecha = info.pf_fecha;
                    Entity.pf_fecha_vcto = info.pf_fecha_vcto;
                    Entity.pf_atencion_a = info.pf_atencion_a;
                    Entity.IdBodega = info.IdBodega;
                    Entity.IdVendedor = info.IdVendedor;
                    Entity.pr_dias_entrega = info.pr_dias_entrega;

                    Entity.IdUsuario_modificacion = info.IdUsuario_modificacion;
                    Entity.fecha_modificacion = DateTime.Now;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(fa_proforma_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_proforma Entity = Context.fa_proforma.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal && q.IdProforma == info.IdProforma);
                    if (Entity == null) return false;

                    Entity.estado = info.estado = false;

                    Entity.IdUsuario_anulacion = info.IdUsuario_anulacion;
                    Entity.fecha_anulacion = DateTime.Now;
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
